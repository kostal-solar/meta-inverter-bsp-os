require u-boot-common_${PV}.inc
require u-boot_${PV}.inc

PR:append = ".34"
FILES:${PN} += "/boot"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DEPENDS += "bc-native dtc-native"

SRC_URI:remove = "git://gitlab.denx.de/kostal/u-boot.git;branch=inverter-devel;protocol=ssh \
  file://0001-doc-imx-habv4-remove-cp-of-script.patch \
  file://0002-doc-imx-habv4-add-sign-to-seperate-image.patch \
  file://0003-doc-imx-habv4-make-script-position-independent.patch \
  file://0004-doc-imx-habv4-examples-make-path-replaceable.patch \
  file://0005-doc-imx-habv4-use-node-name-instead-label.patch \
"

SRC_URI:append = " git://git@github.com/kostal-solar/u-boot-imx-os.git;branch=main;protocol=https"

SRCREV:mx6ul-kie-inverter = "515d7b80e00cd2864e93da9ab1fd48f18f8aef01"

# always deploy uboot-image
do:deploy[nostamp] += "1"