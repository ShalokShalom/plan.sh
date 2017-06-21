pkg_origin=cosmos

pkg_name=libdvdread
pkg_version=5.0.3
pkg_description="Library that allows easy use of sophisticated DVD navigation features such as DVD menus and multiangle playback"
pkg_upstream_url="https://code.videolan.org/videolan/libdvdread"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_build_deps=('libdvdcss')
pkg_deps=('libdvdcss: for decoding encrypted DVDs')
pkg_source=("ftp://ftp.videolan.org/pub/videolan/libdvdread/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('b7b7d2a782087ed2a913263087083715')

do_build() {

  ./configure --prefix=/usr --enable-static=no
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
