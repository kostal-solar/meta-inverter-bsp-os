DESCRIPTION = "kie SWUPDATE Compound image"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:${THISDIR}/files:"
SECTION = "swupdate"

PR = "r01"

SRC_URI = "file://sw-description"
inherit swupdate

DEPENDS = "openssl-native"

# IMAGE_DEPENDS: list of Yocto images that contains a root filesystem
# it will be ensured they are built before creating swupdate image
IMAGE_DEPENDS = "\
	      kie-image-base \
	      kie-initramfs \
	      "

ROOTFS_IMAGE = "kie-image-base"
INITRAMFS_IMAGE = "fitImage-kie-initramfs"

SWUPDATE_IMAGES = "\
		kie-image-base \
		fitImage-kie-initramfs \
		"

SWUPDATE_IMAGES_FSTYPES[kie-image-base] = ".ext4.gz"
SWUPDATE_IMAGES_FSTYPES[fitImage-kie-initramfs] = "-mx6ul-kie-inverter"

