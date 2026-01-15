# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8812CU"
PKG_VERSION="HEAD"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libc0607/rtl88x2cu-20230728"
PKG_URL="https://github.com/libc0607/rtl88x2cu-20230728/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL8812CU Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
  sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
  sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
  sed -i 's/#EXTRA_CFLAGS += -DCONFIG_BEAMFORMING_MONITOR/EXTRA_CFLAGS += -DCONFIG_BEAMFORMING_MONITOR/g' Makefile
  # 禁用 6GHz 断言，8812 不支持 6G，内核头带 6G 会触发 static_assert
  sed -i 's/^static_assert(ARRAY_SIZE(_nl80211_band_to_rtw_band).*NUM_NL80211_BANDS);/\/\/&/' os_dep/linux/os_ch_utils.c
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
