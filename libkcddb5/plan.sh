pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkcddb5
_pkg_name=libkcddb
pkg_version=${_kdever}
pkg_description="KDE CDDB library"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdemultimedia/libkcddb'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kcodecs' 'ki18n' 'kio' 'kwidgetsaddons' 'libmusicbrainz')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${_pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${_pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${_pkg_name}-${pkg_version}
  #sed -i -e 's|add_subdirectory( kcmcddb )|#add_subdirectory( kcmcddb )|' ${CACHE_PATH}/${_pkg_name}/CMakeLists.txt 
  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd"|V4.5-Based Variant V1.1//EN" "dtd/kdedbx45.dtd"|' ${CACHE_PATH}/${pkg_name}/kcmcddb/doc/index.docbook
}

do_build() {
 mkdir -p build
  cd build

  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

