#!/bin/sh

get_root_dev() {

	#Parse kernel cmdline to extract base device path
	CMDLINE="$(cat /proc/cmdline)"
	for c in ${CMDLINE}; do
		if [ "${c:0:5}" == "root=" ]; then
			ROOT_DEV="${c:5}"
		fi
	done
}

get_update_part() {
	OFFSET=$((${#ROOT_DEV}-1))
	CURRENT_PART=${ROOT_DEV:$OFFSET:1}
	# mmc layout:
	if [ $CURRENT_PART -eq "2" ]; then
		ROOTFS_PART="4";
		KERNEL_PART="3";
		BASE_DEV=${ROOT_DEV%?}2
	elif [ $CURRENT_PART -eq "4" ]; then
		ROOTFS_PART="2";
		KERNEL_PART="1";
		BASE_DEV=${ROOT_DEV%?}4
	else
	# Unknown
		ROOTFS_PART="0";
		KERNEL_PART="0";
	fi
}

get_update_dev() {
	ROOTFS_DEV=${ROOT_DEV%?}${ROOTFS_PART}
	KERNEL_DEV=${ROOT_DEV%?}${KERNEL_PART}
}

do_preinst()
{
	echo "Run Pre-Install"
	# get current root device
	get_root_dev
	echo Booted from $ROOT_DEV
	# get the block device to be updated
	get_update_part
	ln -sf $BASE_DEV /dev/swubase
	get_update_dev
	echo Updating $ROOTFS_DEV
	# prepare kernel partition
	# mkfs.ext4 -F -q $KERNEL_DEV >/dev/null || exit 1
	# create symlink for update device
	ln -sf $ROOTFS_DEV /dev/swuroot
	ln -sf $KERNEL_DEV /dev/swukernel
	exit 0
}

do_postinst()
{
	echo "Run Post-Install"
	get_root_dev
	get_update_part
	echo "Update U-Boot variable: mmcpart=$ROOTFS_PART"
	fw_setenv mmcpart $ROOTFS_PART
	fw_setenv fitpart $KERNEL_PART
	/sbin/e2fsck -f -y /dev/mmcblk1p$ROOTFS_PART
	/sbin/resize2fs /dev/mmcblk1p$ROOTFS_PART
	exit 0
}

echo $0 $1

case "$1" in

preinst)
	fw_setenv mmcdev 1
	do_preinst
	fw_setenv mmcdev 1
	;;

postinst)
	fw_setenv mmcdev 1
	do_postinst
	fw_setenv mmcdev 1
	;;

*)
	exit 1
	;;
esac
