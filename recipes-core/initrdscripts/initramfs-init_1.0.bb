SUMMARY = "basic initramfs image init script"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
  file://initramfs \
  file://initramfs-init.sh \
"

PACKAGES = "${PN}"

RDEPENDS_${PN}_append = "busybox util-linux-mount util-linux-findfs \
			 util-linux-uuidd"
			 
S = "${WORKDIR}"

INITFUNCTIONS_INSTALL_DIR ?= "${sysconfdir}/default"

inherit allarch

do_install() {
	install -d ${D}${base_sbindir}
	install -m 0755 ${WORKDIR}/initramfs-init.sh ${D}${base_sbindir}/init

	install -d ${D}/dev
	mknod -m 622 ${D}/dev/console c 5 1
	
	install -d ${D}${sysconfdir}
	install -d ${D}${INITFUNCTIONS_INSTALL_DIR}
	install -m 0755 ${WORKDIR}/initramfs ${D}${INITFUNCTIONS_INSTALL_DIR}
}

FILES_${PN} = "/dev ${base_sbindir}/init"
FILES_${PN} += " \
  ${INITFUNCTIONS_INSTALL_DIR}/initramfs \
"
