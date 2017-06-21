pkg_origin=

pkg_name=fingerprint-gui
pkg_version=1.08
pkg_description="Use fingerprint devices with Linux"
pkg_upstream_url="http://www.ullrich-online.cc/fingerprint/"
pkg_license=('GPL')
pkg_deps=('qca-qt5' 'libfprint' 'libfakekey' 'libusb')
pkg_build_deps=('polkit-qt5')
pkg_source=("http://ullrich-online.cc/nview/Appliance/fingerprint/download/${pkg_name}-${pkg_version}.tar.gz")
install=${pkg_name}.install
pkg_shasum=('5f4163acc051eff1d438199cecc125ec')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  qmake-qt5 PREFIX=/usr LIB=/usr/lib 
  make 
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make -j1 INSTALL_ROOT=${pkg_prefix}/ install 
  
  install -D -m644 ./CHANGELOG ./COPYING ${pkg_prefix}/usr/share/doc/${pkg_name}/
  install -d -m770 ${pkg_prefix}/var/upek_data
  
  install -d ${pkg_prefix}/etc
  install -m644 upek/upek.cfg ${pkg_prefix}/etc/

  install -d ${pkg_prefix}/etc/udev/rules.d
  install -m644 upek/91-fingerprint-gui-upek.rules ${pkg_prefix}/etc/udev/rules.d/
  
  install -d ${pkg_prefix}/usr/lib  
  install -m644 upek/lib64/libbsapi.so.* ${pkg_prefix}/usr/lib/
}
