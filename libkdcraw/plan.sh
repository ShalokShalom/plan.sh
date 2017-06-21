pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkdcraw
pkg_version=${_kdever}
#pkg_version=5.0.90
pkg_description="A library for decoding RAW picture files"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdegraphics/libs'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kio' 'ki18n' 'kconfig' 'kwidgetsaddons' 'libjpeg-turbo' 'libraw')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/libkdcraw.git")
#pkg_shasum=('SKIP')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #sed -i -e 's|add_subdirectory(src)|add_subdirectory(src) add_subdirectory(data)|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
  #patch -p1 -i $CACHE_PATH/CMakeLists.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
