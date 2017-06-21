pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kconfigwidgets
pkg_version=${_kf5ver}
pkg_description='Widgets for configuration dialogs'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kconfigwidgets'
pkg_license=('LGPL')
pkg_deps=('karchive' 'kauth' 'kcodecs' 'kconfig' 'kguiaddons' 'ki18n' 'kwidgetsaddons')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/unstable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  #export XDG_DATA_DIRS="/opt/kf5/share:$XDG_DATA_DIRS"
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
