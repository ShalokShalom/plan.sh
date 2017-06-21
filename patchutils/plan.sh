pkg_origin=cosmos

pkg_name=patchutils
pkg_version=0.3.4
pkg_description="A small collection of programs that operate on patch files"
pkg_license=('GPL')
pkg_upstream_url="http://cyberelk.net/tim/patchutils/"
pkg_deps=('perl')
pkg_source=("http://cyberelk.net/tim/data/patchutils/stable/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('ee95b5993d07ccdf27ca9f2cc4e6ffee')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}

