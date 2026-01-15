# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTW88"
PKG_VERSION="HEAD"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/aircrack-ng/rtl8814au"
PKG_URL="https://github.com/aircrack-ng/rtl8814au/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL88 Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
  sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
  sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
}

make_target() {
  make -C $(kernel_path) \
       M=$PWD \
       V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       KERNELRELEASE=4.9.269 \
       CONFIG_RTL8814AU=m \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
