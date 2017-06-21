pkg_origin=cosmos

pkg_name=libdvdnav
pkg_version=5.0.3
pkg_description="The library for xine-dvdnav plugin."
pkg_license=('GPL')
pkg_upstream_url="https://code.videolan.org/videolan/libdvdnav"
pkg_deps=('libdvdread')
pkg_source=("ftp://ftp.videolan.org/pub/videolan/libdvdnav/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('e9ea4de3bd8f204e61301d407d09f033')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
