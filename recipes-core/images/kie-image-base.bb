SUMMARY = "Base image for Kostal Inverter"
LICENSE = "MIT"
inherit core-image

IMAGE_FEATURES += "package-management"
IMAGE_LINGUAS = "en-us"

IMAGE_FSTYPES = "ext4 ext4.gz squashfs tar.bz2"

IMAGE_ROOTFS_EXTRA_SPACE = "131072"

IMAGE_INSTALL = "\
	packagegroup-core-boot \
	packagegroup-swupdate \
	kernel-modules \
	ethtool \
	i2c-tools \
	util-linux \
	openssh \
	nano \
	bash \
	ntpdate \
	coreutils \
	iw \
	wpa-supplicant \
	hostapd \
	bridge-utils \
	net-tools \
	iproute2 \
	dhcp-server \
	libgpiod \
	libgpiod-tools \
	wireless-regdb-static \
	linux-firmware-imx-sdma-imx6q \
	linux-firmware-sd8801 \
	bootcount \
	bridge-mac \
"
export IMAGE_BASENAME = "kie-image-base"

remove_boot() {
	rm -rf ${IMAGE_ROOTFS}/boot/*
}
ROOTFS_POSTPROCESS_COMMAND += " remove_boot ; "
