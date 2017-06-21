pkg_origin=cosmos

pkg_name=xf86-video-vmware
pkg_version=13.2.1
pkg_description="X.org vmware video driver"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libdrm' 'mesa' 'llvm')
pkg_build_deps=('xorg-server' 'resourceproto' 'scrnsaverproto')
groups=('xorg-video-drivers')
pkg_source=("http://xorg.freedesktop.org/releases/individual/driver/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('4c3912e4d8947f6c2fc1ee9e2f211d74')

do_build() {

  ./configure --prefix=/usr --enable-vmwarectrl-client
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
