# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8812EU"
PKG_VERSION="HEAD"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libc0607/rtl88x2eu-20230815"
PKG_URL="https://github.com/libc0607/rtl88x2eu-20230815/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL8812EU Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
  sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
  sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
  sed -i 's/#EXTRA_CFLAGS += -DCONFIG_BEAMFORMING_MONITOR/EXTRA_CFLAGS += -DCONFIG_BEAMFORMING_MONITOR/g' Makefile

}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
