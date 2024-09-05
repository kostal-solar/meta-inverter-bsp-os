#!/bin/sh
#
# see meta-secure-imx for secure images
#
# start preinit

#set -x
PATH=/sbin:/bin:/usr/sbin:/usr/bin

ROOT_MNT="/mnt"
ROOT_OPT="-o ro"

# mount/umount
MOUNT="/bin/mount"
UMOUNT="/bin/umount"

#include functions
. /etc/default/initramfs

# init
if [ -z ${INIT} ];then
    INIT=/sbin/init
fi

mount_pseudo_fs() {
    debug "Mount pseudo fs"
    ${MOUNT} -t devtmpfs none /dev
    ${MOUNT} -t tmpfs tmp /tmp
    ${MOUNT} -t proc proc /proc
    ${MOUNT} -t sysfs sysfs /sys
}

umount_pseudo_fs() {
    debug "Umount pseudo fs"
    ${UMOUNT} /dev
    ${UMOUNT} /tmp
    ${UMOUNT} /proc
    ${UMOUNT} /sys
}

debug_reboot() {
    if [ "${DEBUGSHELL}" == "yes" ]; then
    echo "enter debugshell"
    /bin/sh
    else
    # wait 5 seconds then reboot
    echo "Reboot in 5 seconds..." > /dev/console
    sleep 5
    reboot -f
    fi
}

error_exit() {
    echo "ERROR: ${@}" > /dev/console
    debug_reboot
}

error() {
    logger -t error -s "${@}"
}

debug() {
    if [ "$VERBOSE" != "no" ]; then
    echo "${@}"
    else
    if [ "$ENABLELOG" != "no" ]; then
        logger -s "${@}"
    fi
    fi
}

parse_cmdline() {
    #Parse kernel cmdline to extract base device path
    CMDLINE="$(cat /proc/cmdline)"
    debug "Kernel cmdline: $CMDLINE"

    # Only extract ROOT_DEV when it is not set previously
    if [ -z ${ROOT_DEV} ]; then
        debug "extracting ROOT_DEV."
    for c in ${CMDLINE}; do
        if [ "${c:0:5}" == "root=" ]; then
        ROOT_DEV="${c:5}"
        fi
    done
    fi
    debug "ROOT_DEV $ROOT_DEV"

    grep enablelog /proc/cmdline > /dev/null
    if [ $? -eq 0 ]; then
    ENABLELOG="yes"
    fi
    grep debugshell /proc/cmdline > /dev/null
    if [ $? -eq 0 ]; then
    DEBUGSHELL="yes"
    fi
    grep enterinitramfs /proc/cmdline > /dev/null
    if [ $? -eq 0 ]; then
    ENTERINITRAMFS="yes"
    fi
}

wait_rootfs() {
    # wait endless for rootfs, as WDT triggers if rootfs
    # does not come up
    debug "wait for root fs:  ${ROOT_FS} ..."
    DEV=$(echo $1 | cut -d "/" -f 3)
    debug "DEV ${DEV}"

    BLKDEV=$(echo $DEV | cut -d "p" -f 1)
    PARTDEV=$(echo $DEV | cut -d "p" -f 2)
    debug "BLKDEV ${BLKDEV} partdev ${PARTDEV}"

    LOOP="notset"
    while [ $LOOP != "FOUND" ];do
        sleep 0.5
        LOOP=$(dmesg | grep $BLKDEV | grep p$PARTDEV | while IFS= read -r line ; do if echo $line | grep Kernel > /dev/null; then true; else echo "FOUND"; fi; done)
    done
}

mount_pseudo_fs
get_root_dev_path

echo "Initramfs Bootstrap..."
parse_cmdline

# Check root device
debug "Root mnt   : ${ROOT_MNT}"
debug "Root device: ${ROOT_DEV}"
debug "Root opt   : ${ROOT_OPT}"

if [ "${ROOT_DEV}" == "" ] || [ "${ROOT_DEV}" == "/dev/nfs" ]; then
    error_exit
fi

if [ "${DEBUGSHELL}" == "yes" ]; then
    sh
fi


ROOT_FS=$(findfs ${ROOT_DEV})
wait_rootfs ${ROOT_FS}
mkdir -p ${ROOT_MNT}
mount ${ROOT_OPT} ${ROOT_DEV} ${ROOT_MNT}
umount_pseudo_fs

#Switch to real root
echo "Switch to root"
exec switch_root ${ROOT_MNT} ${INIT} ${CMDLINE}
