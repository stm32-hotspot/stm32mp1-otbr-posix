FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

NPM_ANGULAR_NAME="angular-1.8.0.tgz"
NPM_ANGULAR_ANIMATE_NAME="angular-animate-1.6.4.tgz"
NPM_ANGULAR_ARIA_NAME="angular-aria-1.6.4.tgz"
NPM_ANGULAR_MATERIAL_NAME="angular-material-1.1.4.tgz"
NPM_ANGULAR_MESSAGES_NAME="angular-messages-1.6.4.tgz"
NPM_ANGULAR_D3_NAME="d3-3.5.17.tgz"
NPM_ANGULAR_MATERIAL_DESIGN_LITE_NAME="material-design-lite-1.3.0.tgz"

SRC_URI:append = "\
    file://rename-ttyACM0-into-ttyUSB0.patch \ 
    file://remove-npm-install.patch \
    https://registry.npmjs.org/angular/-/${NPM_ANGULAR_NAME};sha512sum=55d68cc7e424d129256bb079830efb6bc87395c39a93017c9a3956d770e921620395fab001b4922df77c37fa999f3126405e230b88a87c89ddde013bbcbf1966 \
    https://registry.npmjs.org/angular-animate/-/${NPM_ANGULAR_ANIMATE_NAME};sha256sum=f6432a91edd96a3a81eaa71f363162ab35f18547476366ad44bf37aa4ba59762 \
    https://registry.npmjs.org/angular-aria/-/${NPM_ANGULAR_ARIA_NAME};sha256sum=39dd98e98e46d1b602cd8b6bf141b9c45ffa7c4eeb89b2a26cbc000cf525c41e \
    https://registry.npmjs.org/angular-material/-/${NPM_ANGULAR_MATERIAL_NAME};sha256sum=c0918d4bfbcbc096d2c8c264c410b8f874e8978b336b335893268b4f556b5d5d \
    https://registry.npmjs.org/angular-messages/-/${NPM_ANGULAR_MESSAGES_NAME};sha256sum=a898e301503dc3eaff52f0f794a7f9fd612a6230072c2f1b4b5af29cec5083b3 \
    https://registry.npmjs.org/d3/-/${NPM_ANGULAR_D3_NAME};sha256sum=da49ebf01f88a039c748eb4aa682fec45672f7c2abca3b363633b8f835065b35 \
    https://registry.npmjs.org/material-design-lite/-/${NPM_ANGULAR_MATERIAL_DESIGN_LITE_NAME};sha256sum=8d9e7f676ad7b1e3c48875edfe32e2a1734f4e48b28a199fcf261851b90ce629 \
 "

SRCREV = "f062996c2911032613f0346f281876273fe92d17"

LIC_FILES_CHKSUM = "file://LICENSE;md5=87109e44b2fda96a8991f27684a7349c \
                    file://third_party/Simple-web-server/repo/LICENSE;md5=091ac9fd29d87ad1ae5bf765d95278b0 \
                    file://third_party/cJSON/repo/LICENSE;md5=218947f77e8cb8e2fa02918dc41c50d0 \
                    file://third_party/http-parser/repo/LICENSE-MIT;md5=9bfa835d048c194ab30487af8d7b3778 \
                    file://third_party/openthread/repo/LICENSE;md5=543b6fe90ec5901a683320a36390c65f \
                    "

inherit systemd

NODE_MODULES_DIR="${WORKDIR}/build/src/web/web-service/frontend/node_modules/"

addtask get_npm_packages after do_compile before do_install

do_get_npm_packages() {
# Copy downloaded NPM modules from DL_DIR to workdir
   cp ${DL_DIR}/${NPM_ANGULAR_NAME} ${WORKDIR}/
   cp ${DL_DIR}/${NPM_ANGULAR_ANIMATE_NAME} ${WORKDIR}
   cp ${DL_DIR}/${NPM_ANGULAR_ARIA_NAME} ${WORKDIR}
   cp ${DL_DIR}/${NPM_ANGULAR_MATERIAL_NAME} ${WORKDIR}
   cp ${DL_DIR}/${NPM_ANGULAR_MESSAGES_NAME} ${WORKDIR}
   cp ${DL_DIR}/${NPM_ANGULAR_D3_NAME} ${WORKDIR}
   cp ${DL_DIR}/${NPM_ANGULAR_MATERIAL_DESIGN_LITE_NAME} ${WORKDIR}

# Extract the modules tarball to the final directory
   tar -xvf ${WORKDIR}/${NPM_ANGULAR_NAME} --directory ${NODE_MODULES_DIR}/angular
   tar -xvf ${WORKDIR}/${NPM_ANGULAR_ANIMATE_NAME} --directory ${NODE_MODULES_DIR}/angular-animate
   tar -xvf ${WORKDIR}/${NPM_ANGULAR_ARIA_NAME} --directory ${NODE_MODULES_DIR}/angular-aria
   tar -xvf ${WORKDIR}/${NPM_ANGULAR_MATERIAL_NAME} --directory ${NODE_MODULES_DIR}/angular-material
   tar -xvf ${WORKDIR}/${NPM_ANGULAR_MESSAGES_NAME} --directory ${NODE_MODULES_DIR}/angular-messages
   tar -xvf ${WORKDIR}/${NPM_ANGULAR_D3_NAME} --directory ${NODE_MODULES_DIR}/d3
   tar -xvf ${WORKDIR}/${NPM_ANGULAR_MATERIAL_DESIGN_LITE_NAME} --directory ${NODE_MODULES_DIR}/material-design-lite

# Correctly move them as expected by the makefile
   cd ${NODE_MODULES_DIR}/
   mv angular/package/* angular/ ; rm angular/package/ -rf
   mv angular-animate/package/* angular-animate/ ; rm angular-animate/package/ -rf
   mv angular-aria/package/* angular-aria/ ; rm angular-aria/package/ -rf
   mv angular-material/package/* angular-material/ ; rm angular-material/package/ -rf
   mv angular-messages/package/* angular-messages/ ; rm angular-messages/package/ -rf
   mv d3/package/* d3/ ; rm d3/package/ -rf
   mv material-design-lite/package/* material-design-lite/ ; rm material-design-lite/package/ -rf
   cd -
}

EXTRA_OECMAKE:append = "\
    -GNinja \
    -DOT_THREAD_VERSION=1.3 \ 
    -DOTBR_INFRA_IF_NAME=wlan0 \ 
    -DOTBR_BACKBONE_ROUTER=ON \
    -DOPENTHREAD_CONFIG_BACKBONE_ROUTER_ENABLE=ON \
    -DOTBR_DUA_ROUTING=ON \
    -DOT_DUA=OFF \
    -DOT_MLR=OFF \
    -DOTBR_MDNS=mDNSResponder \
    -DOTBR_WEB=ON \
    -DBUILD_TESTING=OFF \ 
    -DCMAKE_BUILD_TYPE="Release" \
    -DOTBR_BORDER_ROUTING=ON \
    -DOTBR_COVERAGE=OFF \
    -DOTBR_SRP_ADVERTISING_PROXY=ON \ 
    -DOTBR_VENDOR_NAME="OpenThread" \
    -DOTBR_PRODUCT_NAME="Border Router" \
    -DOTBR_MESHCOP_SERVICE_INSTANCE_NAME="OpenThread Border Router" \
    -DOT_DUA=OFF \
    -DOT_POSIX_SETTINGS_PATH='"/tmp/"' \
    -DOT_MLR=OFF \
    -DOTBR_DBUS=ON \ 
    -DOT_LOG_LEVEL_DYNAMIC=OFF \
    -DOT_FULL_LOGS=ON \
    -DOT_JOINER=ON \
    -DOT_LOG_LEVEL=DEBG \
    -DOPENTHREAD_CONFIG_BACKBONE_ROUTER_DUA_NDPROXYNG_ENABLE=1 \
    -DOOPENTHREAD_CONFIG_BACKBONE_ROUTER_MULTICAST_ROUTING_ENABLE=1 \
    -DOT_FIRWALL=ON \
    -DOT_DUA=ON \
    -DOT_DHCP6_SERVER=ON \
    -DOT_DHCP6_CLIENT=ON \
    -DOTBR_ENABLE_MDNS_MDNSSD=1 \
    -DOTBR_TREL=ON \
    -DOT_BACKBONE_ROUTER_MULTICAST_ROUTING=ON \
    -DOT_COMMISSIONER=ON \
    -DOT_COAP=ON \
    -DOT_COAP_BLOCK=OFF \
    -DOT_COAP_OBSERVE=ON \
    -DOT_COAPS=ON \
    -DOT_BORDER_ROUTER=ON\
    -DOTBR_BODER_ROUTING_NAT64=ON \
    -DOTBR_BORDER_AGENT=ON \
    -DOT_DNS_CLIENT_SERVICE_DISCOVERY=ON \
    -DOT_DNS_CLIENT=ON \
    -DOT_ECDSA=ON \
    -DOTBR_REST=ON \
    -DOT_SRP_SERVER=ON \
    -DOT_SRP_CLIENT=ON \
    -DOTBR_DNSSD_DISCOVERY_PROXY=ON \
    -DOT_REFERENCE_DEVICE=ON \
    -DOT_DNSSD_SERVER=ON \
    -DOTBR_NAT64=ON \
"

DEPENDS:append = "  jsoncpp boost pkgconfig-native libnftnl  nftables libnetfilter-queue nodejs-native mdns avahi dbus iproute2 bind"

RDEPENDS:${PN}:append = "   jsoncpp mdns radvd  libnftnl libnetfilter-queue nftables bash bind"
