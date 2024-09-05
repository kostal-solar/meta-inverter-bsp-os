#@TYPE: Machine
#@NAME: Kostal 'inverter' board

include conf/machine/include/tune-cortexa7.inc

UBOOT_NAME = "u-boot-ivt"
UBOOT_ENTRYPOINT = "0x87800000"
UBOOT_MAKE_TARGET = ""
UBOOT_SUFFIX = "img"
SPL_BINARY = "SPL"
UBOOT_BINARY = "${UBOOT_NAME}.${UBOOT_SUFFIX}"
UBOOT_CONFIG = "emmc"
UBOOT_CONFIG[emmc] = "kostal_kie_ull_defconfig"
UBOOT_SIGN_SUFFIX = "signed"

PREFERRED_PROVIDER_virtual/bootloader = "u-boot"
PREFERRED_PROVIDER_u-boot = "u-boot"
PREFERRED_PROVIDER_u-boot-tools = "u-boot-tools"
PREFERRED_PROVIDER_u-boot-tools-native = "u-boot-tools-native"
PREFERRED_PROVIDER_u-boot-mkimage = "u-boot-tools"
PREFERRED_PROVIDER_u-boot-mkimage-native = "u-boot-tools-native"

FITLOADADDR ?= "0x82000000"

PREFERRED_PROVIDER_virtual/kernel ?= "linux-stable"
PREFERRED_VERSION_linux-stable ?= "5.4.%"
KERNEL_DEVICETREE = "imx6ull-kie-inverter.dtb imx6ul-kie-inverter.dtb"
INITRAMFS_IMAGE = "kie-initramfs"

KERNEL_CLASSES += "kernel-fitimage"
KERNEL_IMAGETYPE = "fitImage"
KERNEL_SIGN_SUFFIX = "signed"

SERIAL_CONSOLES="115200;ttymxc0"

IMAGE_BOOT_FILES = "fitImage"
EXTRA_IMAGEDEPENDS += "u-boot"

include conf/machine/include/crypt.inc
include conf/machine/include/swu.inc

# Signing the SWUpdate image
SWUPDATE_SIGNING ?= "RSA"
SWUPDATE_PRIVATE_KEY ?= "${TOPDIR}/keys/conf/swu/inverter_pki_priv.pem"
SWUPDATE_PUBLIC_KEY ?= "${TOPDIR}/keys/conf/swu/inverter_pki_public.pem"
SWUPDATE_PASSWORD_FILE ?= "${TOPDIR}/keys/conf/swu/inverter_pki_priv.pass"
