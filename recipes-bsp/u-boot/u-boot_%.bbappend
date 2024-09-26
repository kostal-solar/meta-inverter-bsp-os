FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "git://git@github.com/kostal-solar/u-boot-imx-os.git;branch=main;protocol=https \
	   file://fw_env.config \
"
SRCREV = "515d7b80e00cd2864e93da9ab1fd48f18f8aef01"

#SRC_URI_remove = "file://remove-redundant-yyloc-global.patch"