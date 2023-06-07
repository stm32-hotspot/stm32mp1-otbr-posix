# Copyright (C) 2022, STMicroelectronics - All Rights Reserved
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Framework components for the OpenThread Boarder Router on STM32MP1"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit packagegroup

RDEPENDS:${PN} = " \
    dhcpcd \
    dnsmasq \
    ncurses \
    nodejs \
    ot-br-posix \
    ot-br-posix-install \
    rsyslog \
    ipset\
    bind \
    "
