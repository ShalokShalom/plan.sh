pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ffmpegthumbs
pkg_version=${_kdever}
#pkg_version=15.07.70
pkg_description="ffmpeg-based thumbnail creator for video files."
pkg_upstream_url="https://projects.kde.org/projects/kde/kdemultimedia/ffmpegthumbs"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ffmpeg' 'kio')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
