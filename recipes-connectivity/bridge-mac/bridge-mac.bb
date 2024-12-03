# (C) Copyright 2022
# Lukasz Majewski, DENX Software Engineering, lukma@denx.de.
#
# This recipe installs on final rootfs systemd service to handle
# setting the MAC address for br0 bridge

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

RDEPENDS:${PN} = "busybox ocotp-get-mac"

FILESEXTRAPATHS:prepend := "${THISDIR}/scripts:"
SRC_URI += "file://bridge-mac.service"

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "bridge-mac.service"

do_install() {
	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/bridge-mac.service ${D}${systemd_unitdir}/system
}

FILES:${PN} += "${bindir}"
FILES:${PN} += "${systemd_unitdir}/system/bridge-mac.service"
