FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "https://github.com/kostal-industrie/u-boot-imx-os.git;branch=main;protocol=https \
	   file://kostal_imx_patch.patch \
	   file://fw_env.config \
"
SRCREV = "86e67d993668f617d83f25e704d6e77506433856"

SRC_URI_remove = "file://remove-redundant-yyloc-global.patch"
