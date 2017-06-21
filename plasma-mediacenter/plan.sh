pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=plasma-mediacenter
pkg_version=${_plasmaver}
pkg_description="A Media Center for the KDE Software Compilation based on plasma technology"
pkg_upstream_url="https://projects.kde.org/projects/playground/multimedia/plasma-mediacenter"
pkg_license=('GPL3')
pkg_deps=('kguiaddons' 'kio' 'kconfigwidgets' 'kwindowsystem' 'plasma-desktop' 'taglib'
         'ffmpegthumbs' 'qt5-multimedia')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("http://download.kde.org/stable/plasma/$_plasmaver/${pkg_name}-$_plasmaver.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${CACHE_PATH}/${pkg_name}-${__pkg_version}
  #sed -i -e 's|add_subdirectory(tests)|#add_subdirectory(tests)|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt 
  #sed -i -e 's|add_subdirectory(test)|#add_subdirectory(test)|' ${CACHE_PATH}/${pkg_name}/libs/CMakeLists.txt
}

build () {
  mkdir -p build

  cd build
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=FALSE 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}


   
 
