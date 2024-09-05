# (C) Copyright 2022
# Lukasz Majewski, DENX Software Engineering, lukma@denx.de.
#
# This recipe installs on final rootfs script to handle
# reading of the OCOTP programmed MAC addresses

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

RDEPENDS_${PN} = "busybox"

FILESEXTRAPATHS_prepend := "${THISDIR}/scripts:"
SRC_URI += "file://ocotp_get_mac"

do_install() {
	install -m 0755 -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/ocotp_get_mac ${D}${bindir}
}

FILES_${PN} += "${bindir}"
