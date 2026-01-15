# SPDX-License-Identifier: Zlib

PKG_NAME="SDL2"
PKG_VERSION="2.26.5"
PKG_LICENSE="zlib"
PKG_SITE="https://www.libsdl.org"
PKG_URL="https://www.libsdl.org/release/SDL2-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Simple DirectMedia Layer 2.0 (fbdev + GLES)"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
  --enable-shared \
  --disable-arts \
  --disable-esd \
  --disable-alsa-shared \
  --disable-pulseaudio-shared \
  --disable-jack-shared \
  --disable-sndio \
  --disable-nas \
  --disable-video-x11 \
  --disable-video-wayland \
  --enable-video-opengles \
  --enable-video-fbcon \
  --disable-video-kmsdrm \
  --enable-pthreads \
  --disable-oss \
  --disable-video-directfb \
  --disable-video-vulkan \
  --disable-video-metal \
  --disable-haptic \
  --disable-ibus \
  --disable-fcitx \
  --disable-libudev \
  --disable-libunwind \
  --disable-joystick-virtual \
  --enable-joystick \
  --enable-hidapi \
  --disable-hidapi-libusb \
  --disable-hidapi-hidraw \
  --disable-hidapi-joystick"

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

makeinstall_target() {
  make DESTDIR=${SYSROOT_PREFIX} install
}
