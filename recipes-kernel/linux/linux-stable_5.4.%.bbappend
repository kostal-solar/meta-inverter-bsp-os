FILESEXTRAPATHS_append := "${THISDIR}/linux-5.4:"

inherit fitimage-hab-sign

KBRANCH = "linux-5.4.y"
LINUX_VERSION = "5.4.24"
LINUX_KERNEL_TYPE = "stable"
LINUX_VERSION_EXTENSION = "-${LINUX_KERNEL_TYPE}"
SRCREV_machine = "cff670b3eb68257029e2977a6bfeac7d9b829e9a"
PV = "${LINUX_VERSION}"

require linux-crypto-imx.inc

SRC_URI += "file://defconfig \
	    file://encryption.cfg \
	    file://0001-dts-kostal-inverter-board-support.patch \
	    file://0002-Add-fbtft-support-for-ST75256.patch \
	    file://0003-dts-kostal-inverter-board-led-support.patch \
	    file://0004-dts-kostal-inverter-board-led-support.patch \
	    file://0001-net-dsa-allow-switch-drivers-to-override-default-sla.patch \
	    file://0002-net-dsa-mv88e6xxx-account-for-PHY-base-address-offse.patch \
	    file://0003-net-dsa-mv88e6xxx-implement-get_phy_address.patch \
	    file://0004-net-dsa-mv88e6xxx-add-support-for-MV88E6020-switch.patch \
	    file://0001-dts-Remove-fec1-related-description.patch \
	    file://0002-dts-Adjust-DTS-to-support-mv88e6020-switch.patch \
	    file://0003-dts-Re-enable-reset-for-mv88e6020-switch.patch \
	    file://0004-dts-Change-pinmux-configuration-for-ENET2_RX_ER-pin-.patch \
	    file://0005-dts-Provide-DTS-properties-to-support-interrupts-fro.patch \
	    file://0006-Adding-user-interface-module-key-support.patch \
	    file://0001-wifi-Enable-support-for-AzzureWave-88W8801-SoC-in-th.patch \
	    file://0001-enet-clock-Disable-the-ENET2_TX_CLK-output-driver.patch \
	    file://0001-dts-clk-enet-Do-not-enable-enet_clk_ref-and-enet_out.patch \
	    file://0001-dts-usdhc2-Provide-proper-pin-configuration-to-suppo.patch \
	    file://0001-ARM-dts-imx6ull-add-rng.patch \
	    file://0002-hwrng-imx-rngc-improve-dependencies.patch \
	    file://0003-hwrng-imx-rngc-enable-driver-for-i.MX6.patch \
	    file://0001-scripts-dtc-Remove-redundant-YYLOC-global-declaratio.patch \
	    file://0001-dts-Exclude-common-Kostal-device-tree-description-to.patch \
	    file://0002-dts-Add-imx6ul-kie-inverter.dts-file.patch \
		file://0013-Reducing-i2c-bus-speed-to-10000.patch \
		file://0014-perf-Make-perf-able-to-build-with-latest-libbfd.patch \
	    file://imx6ull_defconfig_performance_fix.cfg \
	"

SRC_URI_remove = "file://0012-symmetric_keys-Fix-key-buffer-usage.patch"

KERNEL_MODULE_AUTOLOAD = "mwifiex imx-sdma"
