pkg_origin=cosmos

pkg_name=mdds
pkg_version=1.2.3
pkg_description="Collection of multi-dimensional data structures and indexing algorithm"
pkg_upstream_url="https://gitlab.com/mdds/mdds"
pkg_license=('MIT')
checkpkg_deps=('boost')
#pkg_source=("https://gitlab.com/mdds/mdds/repository/archive.tar.gz?ref=${pkg_version}")
pkg_source=("http://kohei.us/files/mdds/src/mdds-${pkg_version}.tar.bz2")
pkg_shasum=('0236b4879acaf06b0a9d7ff050305958')

do_build() {

  #./autogen.sh
  ./configure --prefix=/usr
  # header files only, so no "make"
}

check() {

  make check
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
