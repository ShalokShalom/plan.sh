pkg_origin=

pkg_name=routino
pkg_version=3.2
pkg_description='Finding a route between two points using the dataset of topographical information collected by OpenStreetMap Data'
pkg_upstream_url='https://www.routino.org/'
pkg_license=('AGPL3')
pkg_deps=('zlib' 'bzip2')
pkg_source=("https://www.routino.org/download/${pkg_name}-${pkg_version}.tgz")
pkg_shasum=('e3bf9aa8d033c4ae960d518557404641')

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  sed -i 's|prefix=/usr/local|prefix=/usr|' Makefile.conf
  sed -i 's|docdir=$(prefix)/doc/routino|docdir=$(prefix)/share/doc/routino|' Makefile.conf
}

do_build() {
  cd ${pkg_name}-${pkg_version}

  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
    
  make DESTDIR=${pkg_prefix} install
}
