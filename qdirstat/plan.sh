pkg_origin=

pkg_name=qdirstat
pkg_version=1.4
pkg_description="Qt-based directory statistics: KDirStat without any KDE -- from the author of the original KDirStat."
pkg_upstream_url="https://github.com/shundhammer/qdirstat"
pkg_license=('GPL')
pkg_deps=('qt5-base')
pkg_build_deps=('qt5-tools')
pkg_source=("https://github.com/shundhammer/qdirstat/archive/${pkg_version}.tar.gz")
pkg_shasum=('fcd3bcbdb5a78a1ea64bf3f8c12f392e')

do_build() {  
  cd ${pkg_name}-${pkg_version}

  /usr/lib/qt5/bin/qmake
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make INSTALL_ROOT=${pkg_prefix} install
}
