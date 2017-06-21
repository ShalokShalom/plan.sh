pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kscreen
pkg_version=${_plasmaver}
pkg_description="KDE's screen management software"
pkg_upstream_url='https://github.com/KDE/kscreen'
pkg_license=('GPL' 'LGPL')
pkg_deps=('kdbusaddons' 'kconfigwidgets' 'ki18n' 'kxmlgui' 'kglobalaccel' 'libkscreen')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
#pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.xz ../kf5.md5 | cut -d" " -f1`)
pkg_shasum=('7800abb64d02aa8d58d48f05ebf3134a')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install  
  
  rm -r ${pkg_prefix}/usr/share/locale
}
