FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "\
    file://rename-ttyACM0-into-ttyUSB0.patch \ 
 "

SRCREV = "f062996c2911032613f0346f281876273fe92d17"

LIC_FILES_CHKSUM = "file://LICENSE;md5=87109e44b2fda96a8991f27684a7349c \
                    file://third_party/Simple-web-server/repo/LICENSE;md5=091ac9fd29d87ad1ae5bf765d95278b0 \
                    file://third_party/cJSON/repo/LICENSE;md5=218947f77e8cb8e2fa02918dc41c50d0 \
                    file://third_party/http-parser/repo/LICENSE-MIT;md5=9bfa835d048c194ab30487af8d7b3778 \
                    file://third_party/openthread/repo/LICENSE;md5=543b6fe90ec5901a683320a36390c65f \
                    "

inherit systemd 

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
