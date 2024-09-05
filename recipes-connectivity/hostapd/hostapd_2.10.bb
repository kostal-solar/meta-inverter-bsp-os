

SUMMARY = "User space daemon for extended IEEE 802.11 management"
HOMEPAGE = "http://w1.fi/hostapd/"
SECTION = "kernel/userland"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://hostapd/README;md5=c905478466c90f1cefc0df987c40e172"

DEPENDS = "libnl openssl"

SRC_URI = " \
    http://w1.fi/releases/hostapd-${PV}.tar.gz \
	file://hostapd.conf \
	file://accesspoint.rules \
    file://defconfig \
    file://init \
    file://hostapd.service \
"

PR="r0.4"

SRC_URI[md5sum] = "0be43e9e09ab94a7ebf82de0d1c57761"
SRC_URI[sha256sum] = "206e7c799b678572c2e3d12030238784bc4a9f82323b0156b4c9466f1498915d"

S = "${WORKDIR}/hostapd-${PV}"
B = "${WORKDIR}/hostapd-${PV}/hostapd"

inherit update-rc.d systemd pkgconfig features_check

CONFLICT_DISTRO_FEATURES = "openssl-no-weak-ciphers"

INITSCRIPT_NAME = "hostapd"

SYSTEMD_SERVICE_${PN} = "hostapd.service"
SYSTEMD_AUTO_ENABLE_${PN} = "disable"

do_configure_append() {
    install -m 0644 ${WORKDIR}/defconfig ${B}/.config
}

do_compile() {
    export CFLAGS="-MMD -O2 -Wall -g"
    export EXTRA_CFLAGS="${CFLAGS}"
    make V=1
}

do_install() {
    install -d ${D}${sbindir} ${D}${sysconfdir}/init.d ${D}${systemd_unitdir}/system/
    install -m 0644 ${B}/hostapd.conf ${D}${sysconfdir}
    install -m 0755 ${B}/hostapd ${D}${sbindir}
    install -m 0755 ${B}/hostapd_cli ${D}${sbindir}
    install -m 755 ${WORKDIR}/init ${D}${sysconfdir}/init.d/hostapd
    install -m 0644 ${WORKDIR}/hostapd.service ${D}${systemd_unitdir}/system/
    sed -i -e 's,@SBINDIR@,${sbindir},g' -e 's,@SYSCONFDIR@,${sysconfdir},g' ${D}${systemd_unitdir}/system/hostapd.service
	
	# Install udev rule to create the uap0 interface at boot time
	mkdir -p ${D}${sysconfdir}/udev/rules.d/
	install -m 0600 ${WORKDIR}/accesspoint.rules ${D}${sysconfdir}/udev/rules.d/
}

CONFFILES_${PN} += "${sysconfdir}/hostapd.conf"

# Do not start hostapd service by default on boot
SYSTEMD_AUTO_ENABLE_${PN} = "disable"
