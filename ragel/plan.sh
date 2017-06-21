pkg_origin=
pkg_name=ragel
pkg_version=6.10
pkg_description="Compiles executable finite state machines from regular languages, targeting C, C++, Obj-C, C#, D, Java, Go and Ruby."
pkg_upstream_url="http://www.complang.org/ragel/"
pkg_license=('GPL')
pkg_deps=('gcc-libs')
pkg_source=("http://www.colm.net/files/ragel/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('748cae8b50cffe9efcaa5acebc6abf0d')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix}/ install
}
