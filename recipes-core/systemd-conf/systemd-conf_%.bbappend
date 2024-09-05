FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://10-br0.network \
    file://20-lan-br0.network \
    file://br0.netdev \
"

FILES_${PN} += " \
    ${sysconfdir}/systemd/network/10-br0.network \
    ${sysconfdir}/systemd/network/20-lan-br0.network \
    ${sysconfdir}/systemd/network/br0.netdev \
"

do_install_append() {
 install -d ${D}${sysconfdir}/systemd/network
 install -m 0644 ${WORKDIR}/10-br0.network ${D}${sysconfdir}/systemd/network
 install -m 0644 ${WORKDIR}/20-lan-br0.network ${D}${sysconfdir}/systemd/network
 install -m 0644 ${WORKDIR}/br0.netdev ${D}${sysconfdir}/systemd/network
 
 sed -i -e 's/.*RuntimeMaxUse.*/RuntimeMaxUse=8M/' ${D}${systemd_unitdir}/journald.conf.d/00-${PN}.conf

 # Set the maximium size of individual runtime journal files to 1M as default
 sed -i -e 's/.*RuntimeMaxFileSize.*/RuntimeMaxFileSize=1M/' ${D}${systemd_unitdir}/journald.conf.d/00-${PN}.conf

 # Set a maximum of 1000 messages withnin 5 seconds for a service
 sed -i -e 's/.*RateLimitIntervalSec.*/RateLimitIntervalSec=5s/' ${D}${systemd_unitdir}/journald.conf.d/00-${PN}.conf
 sed -i -e 's/.*RateLimitBurst.*/RateLimitBurst=1000/' ${D}${systemd_unitdir}/journald.conf.d/00-${PN}.conf

 # Don't use syslog
 sed -i -e 's/.*ForwardToSyslog.*/ForwardToSyslog=no/' ${D}${systemd_unitdir}/journald.conf.d/00-${PN}.conf
}
