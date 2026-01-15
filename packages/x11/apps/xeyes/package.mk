# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2024 YOUR_NAME
# xeyes - a follow-the-mouse demo for X

PKG_NAME="xeyes"
PKG_VERSION="1.3.0"          # 请检查并更新为最新版本
PKG_LICENSE="MIT"
PKG_SITE="http://www.x.org"
PKG_URL="https://www.x.org/releases/individual/app/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libX11 libXext libXrender libXmu libXt libXft libSM libICE"
PKG_LONGDESC="Xeyes is a client application that displays a pair of eyes which follow the pointer as it moves around the screen."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

# xeyes 的配置选项
PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --enable-shared \
                           --with-gnu-ld \
                           --disable-debug \
                           --disable-silent-rules \
                           --x-includes=${SYSROOT_PREFIX}/usr/include \
                           --x-libraries=${SYSROOT_PREFIX}/usr/lib "

# 可选：如果你希望链接到自定义的X库路径（比如你的/storage/xorg），可以这样设置
# PKG_CONFIGURE_OPTS_TARGET+=" --x-includes=/storage/xorg/include --x-libraries=/storage/xorg/lib"

post_makeinstall_target() {
  # 确保可执行文件具有正确权限
  chmod +x ${INSTALL}/usr/bin/xeyes 2>/dev/null
  
  # 可选：移除不必要的开发文件
  rm -f ${INSTALL}/usr/lib/*.la 2>/dev/null
}

# 如果需要，可以在配置前设置特定环境变量
# pre_configure_target() {
#   export CFLAGS="${CFLAGS} -I${SYSROOT_PREFIX}/usr/include"
#   export LDFLAGS="${LDFLAGS} -L${SYSROOT_PREFIX}/usr/lib"
# }
