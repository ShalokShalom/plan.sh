pkg_origin=

pkg_name=sqlitebrowser
pkg_version=3.9.1
pkg_description="High quality, visual, open source tool to create, design, and edit database files compatible with SQLite"
pkg_upstream_url="http://sqlitebrowser.org/"
pkg_license=('GPL')
pkg_deps=('qt5-base' 'sqlite' 'sqlcipher')
pkg_build_deps=('cmake' 'qt5-tools')
pkg_source=("https://github.com/sqlitebrowser/sqlitebrowser/archive/v${pkg_version}.tar.gz")
pkg_shasum=('edf47a4baa8c53e9151032152e3c2991')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  sed -e "s|DB Browser for SQLite|sqlitebrowser|" -i CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_QT5=TRUE
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
