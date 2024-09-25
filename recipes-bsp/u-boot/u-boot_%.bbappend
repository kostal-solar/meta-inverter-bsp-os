FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "git://github.com/kostal-solar/u-boot-imx-os.git;branch=main;protocol=https"
SRC_URI += "file://fw_env.config"

SRCREV = "b04e8277d72642faa09dffecccd49216be4ea6ae"
SRC_URI[sha256sum] = "4cdc222e802e4e66610eaa8f65af0f1d674ec797b0f6c3e380c16758c6b9ca68"
SRC_URI_remove = "file://remove-redundant-yyloc-global.patch"
