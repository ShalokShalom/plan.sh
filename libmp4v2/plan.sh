pkg_origin=cosmos

pkg_name=libmp4v2
pkg_version=2.0.0
pkg_description="MPEG-4 library"
pkg_license=('MPL')
pkg_upstream_url="http://code.google.com/p/mp4v2/"
pkg_deps=('gcc-libs')
pkg_source=("http://mp4v2.googlecode.com/files/mp4v2-${pkg_version}.tar.bz2")
pkg_shasum=('c91f06711225b34b4c192c9114887b14')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  make DESTDIR=${pkg_prefix} install-man
}
