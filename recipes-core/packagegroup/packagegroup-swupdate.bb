SUMMARY = "SWUpdate package group"
DESCRIPTION = "Packages for SWUpdate"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r1"

inherit packagegroup

RDEPENDS_${PN} = "\
                   util-linux \
		   libubootenv-bin \
                   swupdate \
                   swupdate-progress \
                   swupdate-www \
                   swupdate-client \
                   swupdate-tools-hawkbit \
                 "
