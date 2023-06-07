SUMMARY = "OpenThread Border Router installer"
DESCRIPTION = "This script will let you setup your own \
OpenThread Border Router in just a few seconds.\
"

LICENSE = "BSD-3-Clause & MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
		    file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
"

SRC_URI = " \
    file://ot-br-posix-install.tgz \
   "

S = "${WORKDIR}"

RDEPENDS:${PN} += " \
    bash \
"
#    ot-br-posix 

FILES:${PN} += " \
    ${bindir} \
    ${libexecdir}/otbr-install \
"

# No need these tasks
do_configure[noexec] = "1"
do_compile[noexec] = "1"

script_list = " \
    _border_routing \
    _dns64 \
    _initrc \
    _ipforward \
    _nat64 \
    _otbr \
"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/otbr_setup.sh ${D}${bindir}

    install -d ${D}${libexecdir}/otbr-install
    for f in ${script_list}; do
        install -m 0755 ${S}/$f ${D}${libexecdir}/otbr-install
    done
}
