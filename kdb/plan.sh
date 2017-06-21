pkg_origin=

pkg_name=kdb
pkg_version=3.0.1.1
_pkg_version=3.0.1
pkg_description="Database connectivity and creation framework for various database vendors"
pkg_upstream_url='https://github.com/KDE/kdb'
pkg_license=('LGPL')
pkg_deps=('kcoreaddons' 'sqlite')
pkg_build_deps=('extra-cmake-modules' 'icu' 'python2' 'postgresql' 'qt5-tools')
optpkg_deps=('postgresql: PostgreSQL database driver')
#pkg_source=("https://github.com/KDE/kdb/archive/${_commit}.zip")
pkg_source=("https://download.kde.org/stable/kdb/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('a2398a345a6c5a31f1848487b0afc37b')

do_prepare() {
  cd $pkg_name-${_pkg_version}
  #sed -i -e 's|K_GLOBAL_STATIC|Q_GLOBAL_STATIC|' ${CACHE_PATH}/${pkg_name}/src/wrtembed/KReportDpi.cpp
  #patch -p1 -i $CACHE_PATH/0003-Port-from-K_GLOBAL_STATIC-to-Q_GLOBAL_STATIC.patch
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
