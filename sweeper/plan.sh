pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=sweeper
#pkg_version=${_kdever}
pkg_version=16.08.71
_commit=e3240994ea7ca928d52202c8e094033a59dc8213
pkg_description="Clean unwanted traces the user leaves on the system"
pkg_upstream_url="https://github.com/KDE/sweeper"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kbookmarks' 'kcrash' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'ki18n' 'kio'
         'ktextwidgets' 'kxmlgui')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
#pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("https://github.com/KDE/sweeper/archive/${_commit}.zip")
pkg_shasum=('372195800e1622aa1fd9bdc1d438f103')

do_prepare() {
  cd ${pkg_name}-${_commit}
  #sed -i -e 's/${DATA_INSTALL_DIR}/${KXMLGUI_INSTALL_DIR}/' ${CACHE_PATH}/${pkg_name}/src/CMakeLists.txt
}

do_build() {
  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
