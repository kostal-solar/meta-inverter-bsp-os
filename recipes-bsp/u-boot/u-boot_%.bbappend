FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "git://git.de.kostal.int:7999/puck/u-boot-imx.git;branch=inverter-devel;protocol=ssh \
	   file://fw_env.config \
"
SRCREV = "86e67d993668f617d83f25e704d6e77506433856"

SRC_URI_remove = "file://remove-redundant-yyloc-global.patch"
