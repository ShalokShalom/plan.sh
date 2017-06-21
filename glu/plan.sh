pkg_origin=cosmos

pkg_name=glu
pkg_version=9.0.0
pkg_description="Mesa OpenGL Utility library"
pkg_upstream_url="http://cgit.freedesktop.org/mesa/glu/"
pkg_license=('LGPL')
pkg_deps=('libgl')
pkg_source=("ftp://ftp.freedesktop.org/pub/mesa/glu/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('be9249132ff49275461cf92039083030')

do_build() {

  ./configure --prefix=/usr --disable-static
  make
}

check() {

  make -k check
}

do_package() {

  make DESTDIR=$pkg_prefix/ install
}
