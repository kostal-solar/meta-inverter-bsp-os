FILESEXTRAPATHS_append := "${THISDIR}/linux-5.10:"

inherit fitimage-hab-sign

LINUX_VERSION = "5.10.188"
LINUX_KERNEL_TYPE = "stable"
LINUX_VERSION_EXTENSION = "-${LINUX_KERNEL_TYPE}"
PV = "${LINUX_VERSION}"
KBRANCH = "linux-5.10.y"

require linux-crypto-imx.inc

SRC_URI += " \
  file://0001-dts-Kostal-inverter-board-support.patch \
  file://0002-net-dsa-allow-switch-drivers-to-override-default-sla.patch \
  file://0003-net-dsa-mv88e6xxx-account-for-PHY-base-address-offse.patch \
  file://0004-net-dsa-mv88e6xxx-implement-get_phy_address.patch \
  file://0005-net-dsa-mv88e6xxx-add-support-for-MV88E6020-switch.patch \
  file://0006-enet-clock-Disable-the-ENET2_TX_CLK-output-driver.patch \
  file://0007-dts-Change-pinmux-configuration-for-ENET2_RX_ER-pin-.patch \
  file://0008-dts-Provide-DTS-properties-to-support-interrupts-fro.patch \
  file://0009-dts-Adding-user-interface-module-key-support.patch \
  file://0010-dts-wifi-Enable-support-for-AzzureWave-88W8801-SoC-i.patch \
  file://0011-dts-clk-enet-Do-not-enable-enet_clk_ref-and-enet_out.patch \
  file://0012-dts-usdhc2-Provide-proper-pin-configuration-to-suppo.patch \
  file://0013-dts-Exclude-common-Kostal-device-tree-description-to.patch \
  file://0014-dts-Add-imx6ul-kie-inverter.dts-file.patch \
  file://0015-dts-Provide-proper-mmc-aliases.patch \
  file://0016-Reducing-i2c-bus-speed-to-10kHz.patch \
	file://0017-perf-Make-perf-able-to-build-with-latest-libbfd.patch \
"

SRC_URI_append = " \
  file://defconfig \
  file://0013-caam_keyblob.c-fix-from-Richard.patch \
"
