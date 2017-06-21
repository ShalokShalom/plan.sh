pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kpimtextedit
pkg_version=${_kdever}
pkg_description="Advanced text editor which provide advanced html feature."
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/kpimtextedit'
pkg_license=('LGPL')
pkg_deps=('kcoreaddons' 'kemoticons' 'sonnet' 'ktextwidgets' 'kio' 'kcodecs' 'kiconthemes' 'kconfigwidgets'
         'kxmlgui' 'kdesignerplugin' 'syntax-highlighting' 'grantlee') #'qtspeech"
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kpimtextedit.git")
#pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  
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
