#
#	This recipe-extension exchanges the WLAN-firmware with the "official" 14.68.36.p146 version
# 	provided by NXP. The version coming with the linux-firmware package has problems
#	with encrypted connections.
#
#	@author a.buergel@kostal.com
#
#	$Id: $
#	$HeadURL: $
#


FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://sd8801_uapsta.bin"

#
#	appended to the do_install() function in the linux-firmware package
#
do_install_append() {
    install -d ${D}${base_libdir}/firmware/mrvl
    install -m 0755 ${WORKDIR}/sd8801_uapsta.bin ${D}${base_libdir}/firmware/mrvl/sd8801_uapsta.bin
}
