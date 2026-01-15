PKG_NAME="wfb-ng"
PKG_VERSION="HEAD"
PKG_SITE="https://github.com/svpcom/wfb-ng"
PKG_URL="https://github.com/svpcom/wfb-ng/archive/refs/heads/master.tar.gz"
PKG_DEPENDS_TARGET="toolchain libsodium libpcap"
PKG_TOOLCHAIN="make"

make_target() {
  make CC=${CC} CXX=${CXX} wfb_rx wfb_tx wfb_keygen wfb_tun 
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp wfb_rx wfb_tx wfb_keygen ${INSTALL}/usr/bin/
}
