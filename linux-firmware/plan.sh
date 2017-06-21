pkg_origin=cosmos

pkg_name=linux-firmware
pkg_version=20170615
_b43=5.100.138
_legacy=3.130.20.0
pkg_description="Firmware files for Linux"
pkg_upstream_url="http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git"
pkg_license=('GPL2' 'GPL3' 'custom')
pkg_build_deps=('b43-fwcutter' 'git')
           'ar9170-fw'
           'carl9170-fw'
           'iwlwifi-1000-ucode'
           'iwlwifi-3945-ucode'
           'iwlwifi-4965-ucode'
           'iwlwifi-5000-ucode'
           'iwlwifi-5150-ucode'
           'iwlwifi-6000-ucode'
           'rt2870usb-fw'
           'rt2x00-rt61-fw'
           'rt2x00-rt71w-fw'
           'b43-firmware'
           'b43-firmware-legacy'
           'amd-ucode')
           'carl9170'
           'iwlwifi-1000-ucode'
           'iwlwifi-3945-ucode'
           'iwlwifi-4965-ucode'
           'iwlwifi-5000-ucode'
           'iwlwifi-5150-ucode'
           'iwlwifi-6000-ucode'
           'rt2870usb-fw'
           'rt2x00-rt61-fw'
           'rt2x00-rt71w-fw'
           'b43-firmware'
           'b43-firmware-legacy')
pkg_source=("git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git#branch=master"
        "http://mirror2.openwrt.org/sources/broadcom-wl-${_b43}.tar.bz2"
        "http://downloads.openwrt.org/sources/wl_apsta-${_legacy}.o")
pkg_shasum=('SKIP'
         'f4e357b09eaf5d8b1f1920cf3493a555'
         'e08665c5c5b66beb9c3b2dd54aa80cb3')

do_package() {
  cd ${pkg_name}
  
  make DESTDIR=${pkg_prefix} install
  rm ${pkg_prefix}/lib/firmware/{Makefile,README,configure,GPL-3}

  install -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -Dm644 LICEN* WHENCE ${pkg_prefix}/usr/share/licenses/linux-firmware/

  # microcode reload for older systems not using early
  #install -d ${pkg_prefix}/usr/lib/tmpfiles.d
  #echo 'w /sys/devices/system/cpu/microcode/reload - - - - 1' \
  #  >${pkg_prefix}/usr/lib/tmpfiles.d/${pkg_name}.conf

  # install b43-firmware
  b43-fwcutter -w ${pkg_prefix}/lib/firmware/ ${CACHE_PATH}/broadcom-wl-${_b43}/linux/wl_apsta.o

  # install b43-legacy-firmware
  b43-fwcutter -w ${pkg_prefix}/lib/firmware/ ${CACHE_PATH}/wl_apsta-${_legacy}.o
}
