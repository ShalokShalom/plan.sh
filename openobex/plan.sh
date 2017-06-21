pkg_origin=cosmos

pkg_name=openobex
pkg_version=1.7.2
pkg_description="Implementation of the OBject EXchange (OBEX) protocol"
pkg_upstream_url="http://dev.zuckschwerdt.org/openobex/"
pkg_license=('GPL' 'LGPL')
pkg_deps=('bluez' 'libusbx')
pkg_source=("https://downloads.sourceforge.net/openobex/${pkg_name}-${pkg_version}-Source.tar.gz")
pkg_shasum=('f6e0b6cb7dcfd731460a7e9a91429a3a')

do_build() {
  sed -i 's|MODE="660", GROUP="plugdev"|TAG+="uaccess"|' ${pkg_name}-${pkg_version}-Source/udev/openobex.rules.in
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version}-Source \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=/usr/lib 
  make all openobex-apps
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  cp ../${pkg_name}-${pkg_version}-Source/apps/lib/*.h  ${pkg_prefix}/usr/include/openobex/
  install -m644 apps/lib/libopenobex-apps-common.a ${pkg_prefix}/usr/lib/libopenobex-apps-common.a
}
