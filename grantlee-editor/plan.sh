pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=grantlee-editor
pkg_version=${_kdever}
pkg_description="Utilities and tools to manage themes in KDE PIM applications."
pkg_upstream_url='https://github.com/KDE/grantlee-editor'
pkg_license=('LGPL2')
pkg_deps=('kcrash' 'kdbusaddons' 'kxmlgui' 'ktexteditor' 'kwallet' 'knewstuff' 'karchive' 'pimcommon'
         'messagelib' 'grantleetheme' 'akonadi-mime' 'libkleo' 'syntax-highlighting'
         'kdepim-apps-libs' 'kpimtextedit' 'libkdepim')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
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
