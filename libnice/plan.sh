pkg_origin=cosmos

pkg_name=libnice
pkg_version=0.1.14
pkg_description="An implementation of the IETF's draft ICE (for p2p UDP data streams)"
pkg_upstream_url="https://nice.freedesktop.org"
pkg_license=('LGPL')
pkg_deps=('gstreamer' 'libtasn1')
pkg_source=("https://nice.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c9b9b74b8ae1b3890e4bd93f1b70e8ff')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
