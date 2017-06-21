pkg_origin=cosmos

pkg_name=usb_modeswitch
pkg_version=2.5.0
_pkgdata=20170205
pkg_description="Activating switchable USB devices on Linux."
pkg_upstream_url="http://www.draisberghof.de/usb_modeswitch/"
pkg_license=('GPL3')
pkg_deps=('libusb' 'tcl')
pkg_build_deps=('gcc' 'make')
groups=('system')
backup=("etc/${pkg_name}.conf")
pkg_source=("http://www.draisberghof.de/${pkg_name}/usb-modeswitch-${pkg_version}.tar.bz2"
        "http://www.draisberghof.de/${pkg_name}/usb-modeswitch-data-${_pkgdata}.tar.bz2"
        "usb-modeswitch-${pkg_version}-device_reference.txt::http://www.draisberghof.de/${pkg_name}/device_reference.txt"
        '40-usb_modeswitch.diff')
pkg_shasum=('38ad5c9d70e06227a00361bdc2b1e568'
         '0cc107cd0c4c83df0d9400c999e21dfd'
         '91f3b3638f013fd343bd98b251ce646f'
         '1217ad78e4cbd563121faad9b939e56f')

do_prepare() {
  # exclude flip phones, see https://forum.kaosx.us/d/1790-kaos-and-doro-626/12
  patch -p1 -i ${CACHE_PATH}/40-usb_modeswitch.diff
}
         
do_build() {
  make clean
  
  make
}

do_package() {

  mkdir -p ${CACHE_PATH}/usr/lib/udev
  mkdir -p ${CACHE_PATH}/etc
  mkdir -p ${CACHE_PATH}/usr/share/man/man1
  mkdir -p ${CACHE_PATH}/usr/lib/systemd/system

  make DESTDIR=${CACHE_PATH} UDEVDIR=${CACHE_PATH}/usr/lib/udev SYSDIR=${CACHE_PATH}/usr/lib/systemd/system install

  cp ${CACHE_PATH}/usb-modeswitch-${pkg_version}-device_reference.txt ${CACHE_PATH}/etc/usb_modeswitch.setup

  make DESTDIR=${CACHE_PATH} install RULESDIR=${CACHE_PATH}/usr/lib/udev/rules.d
}
