pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kcalc
pkg_version=${_kdever}
pkg_description="Scientific calculator"
pkg_upstream_url="https://www.kde.org/applications/utilities/kcalc"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kguiaddons' 'ki18n' 'kinit' 'knotifications' 'kxmlgui')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # https://bugs.kde.org/show_bug.cgi?id=360105
  sed -i -e 's|setFixedSize(minimumSize());|layout()->setSizeConstraint(QLayout::SetFixedSize);|' kcalc.cpp
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version}  \
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

