# SPDX-FileCopyrightText: Huawei Inc.
#
# SPDX-License-Identifier: Apache-2.0

SUMMARY = "TAYGA Simple, no-fuss NAT64 for Linux"
DESCRIPTION = "TAYGA is an out-of-kernel stateless NAT64 implementation for \
    Linux that uses the TUN driver to exchange IPv4 and IPv6 packets with the \
    kernel. It is intended to provide production-quality NAT64 service for \
    networks where dedicated NAT64 hardware would be overkill."
SECTION = "net"
LICENSE="GPLv2"
LIC_FILES_CHKSUM="file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f"

SRC_URI= "http://www.litech.org/tayga/tayga-0.9.2.tar.bz2 \
          file://tayga.conf \
          file://tayga.service"

SRC_URI[sha256sum] = "2b1f7927a9d2dcff9095aff3c271924b052ccfd2faca9588b277431a44f0009c"

inherit autotools systemd

SYSTEMD_SERVICE:${PN} = "tayga.service"

do_install:append() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/tayga.service ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/tayga.conf ${D}${sysconfdir}
}

SYSTEMD_AUTO_ENABLE:${PN} = "disable"
