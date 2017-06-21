pkg_origin=cosmos
pkg_name=alkimia
pkg_version=5.0.90
pkg_description="A library with common classes and functionality used by finance applications for the KDE SC."
pkg_upstream_url=('http://kde-apps.org/content/show.php/libalkimia?content=137323')
pkg_deps=('kcoreaddons')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'doxygen')
pkg_license=('LGPL')
pkg_source=("git://anongit.kde.org/alkimia")
pkg_shasum=('SKIP')

do_build() {
  #sed -e "s/Qt5::DBus/Qt5::DBus KF5::KDELibs4Support/" -i ${CACHE_PATH}/$_pkg_name/libalkimia/CMakeLists.txt
  #sed -e "s/KDE4_ENABLE_EXCEPTIONS/KDE_ENABLE_EXCEPTIONS/" -i ${CACHE_PATH}/$_pkg_name/libalkimia/CMakeLists.txt

  mkdir build

  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
 
  make DESTDIR="${pkg_prefix}" install  
}
