# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) YOUR_NAME
# xf86-video-fbdev - X.Org driver for framebuffer devices

PKG_NAME="xf86-video-fbdev"
PKG_VERSION="0.5.0"  # 请检查并更新为最新稳定版本
PKG_LICENSE="MIT"
PKG_SITE="http://www.x.org"
PKG_URL="https://www.x.org/releases/individual/driver/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain xorgproto xorg-server"
PKG_LONGDESC="X.Org driver for framebuffer devices."
PKG_TOOLCHAIN="autotools"  # 此驱动通常使用 autotools

# 这是针对 Xorg 视频驱动的标准配置
PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --enable-shared \
                           --with-gnu-ld \
                           --disable-debug \
                           --disable-unit-tests \
                           --with-xorg-module-dir=${XORG_PATH_MODULES}/drivers"

# 安装后钩子：确保驱动文件被正确安装
post_makeinstall_target() {
    # 通常不需要特别操作，但可以在这里添加验证步骤
    if [ ! -f "${INSTALL}${XORG_PATH_MODULES}/drivers/fbdev_drv.so" ]; then
        echo "警告: fbdev_drv.so 可能未正确安装!"
    fi
}

# 可选择：定义包的编译选项（如果需要）
# PKG_DEPENDS_TARGET+=" some-other-pkg-if-needed"
