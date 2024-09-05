FILESEXTRAPATHS_append := "${THISDIR}/files:"

PR_append = ".1"

DEPENDS += "librsync"
RDEPENDE_${PN} += "librsync"
USERADD_PACKAGES = "${PN}"

SRC_URI += "file://defconfig \
	    file://09-swupdate-args \
	    file://swupdate.cfg"

do_install_prepend() {
	PKEY=$(basename ${SWUPDATE_PUBLIC_KEY})
	sed -ie "s#__PUBL_KEY#${sysconfdir}/crts/${PKEY}#g" ${WORKDIR}/swupdate.cfg
}

do_install_append() {

	install -d ${D}${sysconfdir}
        install -d ${D}${sysconfdir}/crts/

	# Certificates are added if configured with artifacts signing
	if [ "${SWUPDATE_SIGNING}" != "" ] && [ -f "${SWUPDATE_PUBLIC_KEY}" ]; then
		install -m 644 "${SWUPDATE_PUBLIC_KEY}" ${D}${sysconfdir}/crts
	fi

        install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}
	echo "rootfs ${DISTRO_VERSION}" > ${D}${sysconfdir}/sw-versions

        cat ${WORKDIR}/09-swupdate-args | sed -e 's/@@MACHINE@@/${MACHINE}/g' > ${WORKDIR}/09-swupdate-args.1
        install -m 644 ${WORKDIR}/09-swupdate-args.1 ${D}${libdir}/swupdate/conf.d/09-swupdate-args

        if [ "${SWU_KEY}" != "" ]; then
	    install -m 400 ${SWU_KEY} ${D}${sysconfdir}/crts/$(basename ${SWU_KEY})
        fi
}

FILES_${PN} += "${sysconfdir}/crts/*"
