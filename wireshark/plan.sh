pkg_origin=

pkg_name=wireshark
pkg_version=2.2.7
pkg_description='Network packet analyzer that will try to capture network packets and tries to display that packet data as detailed as possible'
pkg_upstream_url='https://www.wireshark.org/'
pkg_license=('GPL2')
pkg_deps=('krb5' 'libgcrypt' 'libcap' 'libpcap' 'bash' 'geoip' 'gnutls' 'glib2' 'lua' 'qt5-multimedia'
         'qt5-svg' 'asciidoc' 'portaudio' 'c-ares' 'libssh')
pkg_build_deps=('cmake' 'python2' 'qt5-tools')
pkg_source=("https://www.wireshark.org/download/src/${pkg_name}-${pkg_version}.tar.bz2"
        'version.h.in')
pkg_shasum=('a4d880554c7f925dafef60fa313b580d'
         '45fa502b3b361dd8d3985101c44cee26')

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  #cp ${CACHE_PATH}/version.h.in ${CACHE_PATH}/${pkg_name}-${pkg_version}/version.h.in
}

do_build() {
  cd ${CACHE_PATH}
  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DENABLE_QT5=ON \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  sed -i 's|System;Monitor;GTK;|System;Monitor;Tools;|' ${CACHE_PATH}/${pkg_name}-${pkg_version}/wireshark.desktop
  install -Dm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/wireshark.desktop ${pkg_prefix}/usr/share/applications/wireshark.desktop
}

