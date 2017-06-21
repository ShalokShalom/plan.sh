pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=mailimporter
pkg_version=${_kdever}
pkg_description="Mail importer library"
pkg_upstream_url='https://github.com/KDE/mailimporter'
pkg_license=('LGPL')
pkg_deps=('akonadi' 'ki18n' 'kmime' 'akonadi-mime' 'kconfig' 'karchive' 'libkdepim')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/mailimporter.git")
#pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|set(AKONADIMIME_LIB_VERSION "4.81.0")|set(AKONADIMIME_LIB_VERSION "4.80.0")|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
}

do_build() {
  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
