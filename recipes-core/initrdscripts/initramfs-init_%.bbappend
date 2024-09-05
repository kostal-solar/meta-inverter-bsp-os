FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
  file://initramfs \
"

INITFUNCTIONS_INSTALL_DIR ?= "${sysconfdir}/default"

do_install_append () {
	install -d ${D}${sysconfdir}
	install -d ${D}${INITFUNCTIONS_INSTALL_DIR}
	install -m 0755 ${WORKDIR}/initramfs ${D}${INITFUNCTIONS_INSTALL_DIR}
}

FILES_${PN} += " \
  ${INITFUNCTIONS_INSTALL_DIR}/initramfs \
"
