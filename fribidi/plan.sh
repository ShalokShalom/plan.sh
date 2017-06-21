pkg_origin=cosmos

pkg_name=fribidi
pkg_version=0.19.7
pkg_description="A Free Implementation of the Unicode Bidirectional Algorithm"
pkg_license=('LGPL')
pkg_upstream_url="https://fribidi.org"
pkg_deps=('glib2')
pkg_source=("https://fribidi.org/download/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('6c7e7cfdd39c908f7ac619351c1c5c23')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
