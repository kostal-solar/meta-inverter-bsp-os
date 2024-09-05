# (C) Copyright 2021
# Lukasz Majewski, DENX Software Engineering, lukma@denx.de.
#
# This recipe installs on final rootfs script to handle
# erasing of bootcount counter from user space

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${WORKDIR}/bootcount_erase;endline=1;md5=daad6f7f7a0a286391cd7773ccf79340 \
		    file://${WORKDIR}/bootcount_read;endline=1;md5=daad6f7f7a0a286391cd7773ccf79340"

RDEPENDS_${PN} = "busybox"

FILESEXTRAPATHS_prepend := "${THISDIR}/scripts:"
SRC_URI += "file://bootcount_erase"
SRC_URI += "file://bootcount_read"
SRC_URI += "file://bootcount.service"

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE_${PN} = "bootcount.service"

do_install() {
	install -m 0755 -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/bootcount_erase ${D}${bindir}
	install -m 0755 ${WORKDIR}/bootcount_read ${D}${bindir}

	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/bootcount.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += "${bindir}"
FILES_${PN} += "${systemd_unitdir}/system/bootcount.service"
