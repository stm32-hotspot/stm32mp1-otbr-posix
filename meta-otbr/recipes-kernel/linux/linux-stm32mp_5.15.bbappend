FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Enable ftdi usb devices serial
SRC_URI += " \
    file://${LINUX_VERSION}/fragment-07-ftdi-usb-serial.config;subdir=fragments \
    "

KERNEL_CONFIG_FRAGMENTS += " \
    ${WORKDIR}/fragments/${LINUX_VERSION}/fragment-07-ftdi-usb-serial.config \
    "
