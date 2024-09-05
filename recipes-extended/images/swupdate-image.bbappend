LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEPENDS_append = " u-boot-mkimage-native dtc-native "
do_compile[depends] = "virtual/kernel:do_deploy"
do_prepareitb[depends] = "${PN}:do_unpack"

do_fetch[nostamp] = "1"

INHIBIT_DEFAULT_DEPS = "1"

ENCRYPTION_SW = " \
		coreutils \
		keyutils \
		lvm2 \
		e2fsprogs-mke2fs \
		util-linux \
		"

IMAGE_INSTALL += " \
		devmem2 \
		swupdate \
		swupdate-www \
		libubootenv-bin \
		u-boot-env \
		${ENCRYPTION_SW} \
		mmc-utils \
		"

IMAGE_INSTALL_remove = "mtd-utils mtd-utils-ubifs"

# Ensure the above tarball gets fetched, unpackaged and patched
python () {
    d.delVarFlag("do_fetch", "noexec")
    d.delVarFlag("do_unpack", "noexec")
}

SRC_URI = " \
	file://recovery.its.in \
	"

IMAGE_FSTYPES_append = " ext4.xz"

inherit fitimage-hab-sign

python __anonymous() {
       dts_files = d.getVar("KERNEL_DEVICETREE").split()
       d.setVar('KERNEL_DEVICETREE1', dts_files[0])
       d.setVar('KERNEL_DEVICETREE2', dts_files[1])
       d.setVar('KERNEL_DEVICETREE', "")
}


do_prepareitb () {
	cp ${IMGDEPLOYDIR}/${IMAGE_BASENAME}-${MACHINE}.ext4.xz ${WORKDIR}/

	export KERNEL_DEVICETREE1=${KERNEL_DEVICETREE1}
	export KERNEL_DEVICETREE2=${KERNEL_DEVICETREE2}
	export DEPLOY_DIR_IMAGE=${DEPLOY_DIR_IMAGE}

	sed "s|MACHINE|${MACHINE}|" ${WORKDIR}/recovery.its.in > ${WORKDIR}/recovery.its
	sed -i "s|KERNEL_DEVICETREE1|$KERNEL_DEVICETREE1|g" ${WORKDIR}/recovery.its
	sed -i "s|KERNEL_DEVICETREE2|$KERNEL_DEVICETREE2|g" ${WORKDIR}/recovery.its
	sed -i "s|DEPLOY_DIR_IMAGE|$DEPLOY_DIR_IMAGE|g" ${WORKDIR}/recovery.its

	mkimage -D "-I dts -O dtb -p 0x1000" -f ${WORKDIR}/recovery.its ${WORKDIR}/${IMAGE_BASENAME}.itb
	install -m 0644 ${WORKDIR}/${IMAGE_BASENAME}.itb ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}.itb

	# Provide CSF data required for having HAB verificable image
	cd "${WORKDIR}"
	SWU_HAB_IMAGE="${IMAGE_BASENAME}.itb"

	install ${SWU_HAB_IMAGE} ${DEPLOY_DIR_IMAGE}/${SWU_HAB_IMAGE}.${KERNEL_SIGN_SUFFIX}
}
addtask prepareitb before do_build after do_image_complete

fix_inittab_swupdate () {
	sed -i 's/^S0.*1//' \
		"${IMAGE_ROOTFS}${sysconfdir}/inittab"
	echo "S0:12345:respawn:/bin/start_getty 115200 ttyS0 vt102" >> \
		"${IMAGE_ROOTFS}${sysconfdir}/inittab"
}
ROOTFS_POSTPROCESS_COMMAND += "fix_inittab_swupdate; "

# For better readability provide more meaningfull names for SWUpdate
# rescue initramfs image
IMAGE_BASENAME = "rescue-initramfs"
PROVIDES_append = " ${IMAGE_BASENAME}"
