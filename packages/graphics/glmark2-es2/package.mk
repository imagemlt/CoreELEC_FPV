################################################################################
# glmark2-es2 (X11 + EGL + GLESv2)
# Build-time: requires DRM/GBM to satisfy Meson EGL checks
# Run-time: X11 + EGL
################################################################################

PKG_NAME="glmark2-es2"
PKG_VERSION="2023.01"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/glmark2/glmark2"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"

PKG_DEPENDS_TARGET="
  toolchain
  mesa
  libdrm
  libX11
  libXrandr
  libXcursor
  libXinerama
  libXxf86vm
"

PKG_LONGDESC="OpenGL ES 2.0 benchmark (X11 + EGL backend)"
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="+pic"

################################################################################
# Meson options
################################################################################

PKG_MESON_OPTS_TARGET+="
  -Degl=enabled
  -Dgbm=enabled
  -Dplatforms=x11
  -Ddri3=enabled
  -Dglx=disabled
  -Dopengl=true
  -Dgles2=enabled
"

################################################################################
# Build steps
################################################################################

configure_target() {
  meson setup ${PKG_BUILD}/.${TARGET_NAME} \
    --cross-file ${MESON_CROSS_FILE} \
    --prefix=/usr \
    ${PKG_MESON_OPTS_TARGET}
}

build_target() {
  ninja -C ${PKG_BUILD}/.${TARGET_NAME}
}

install_target() {
  DESTDIR=${INSTALL} ninja -C ${PKG_BUILD}/.${TARGET_NAME} install
}

################################################################################
# Post install cleanup
################################################################################

post_install() {
  # Only keep glmark2-es2 (X11 + EGL)
  rm -f ${INSTALL}/usr/bin/glmark2
  rm -f ${INSTALL}/usr/bin/glmark2-wayland
  rm -f ${INSTALL}/usr/bin/glmark2-drm
}

