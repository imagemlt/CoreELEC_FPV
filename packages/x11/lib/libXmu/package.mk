PKG_NAME="libXmu"
PKG_VERSION="1.2.1"
PKG_LICENSE="MIT"
PKG_SITE="https://www.x.org"
PKG_URL="https://www.x.org/releases/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros xorgproto libXt libXext libX11" # 明确列出 libXt
PKG_LONGDESC="LibXmu provides a set of miscellaneous utility convenience functions for X libraries to use."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --enable-shared \
                           --with-gnu-ld \
                           --disable-docs \
                           --without-fop \
                           --disable-silent-rules"

post_makeinstall_target() {
  rm -f ${INSTALL}/usr/lib/*.la 2>/dev/null
  sed -i "s:^prefix=.*:prefix=${SYSROOT_PREFIX}/usr:g" ${INSTALL}/usr/lib/pkgconfig/xmu.pc ${INSTALL}/usr/lib/pkgconfig/xmuu.pc 2>/dev/null
}
