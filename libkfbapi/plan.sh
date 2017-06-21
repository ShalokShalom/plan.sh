pkg_origin=

pkg_name=libkfbapi
pkg_version=1.0.1
pkg_description="KDE library for accessing Facebook services"
pkg_upstream_url='https://github.com/KDE/libkfbapi'
pkg_license=('GPL')
pkg_deps=('kcoreaddons' 'kio' 'ki18n' 'kaccounts-integration')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'boost' 'qjson')
#pkg_source=("http://download.kde.org/stable/$pkg_name/$pkg_version/src/$pkg_name-$pkg_version.tar.bz2")
pkg_source=("git://anongit.kde.org/libkfbapi.git#branch=frameworks")
pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name
  #sed -i -e 's|add_subdirectory( doc )|#add_subdirectory( doc )|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
