pkg_origin=

pkg_name=tellico
pkg_version=3.0.2
_pkg_version=3.0.2
pkg_description="A collection manager for KDE"
pkg_upstream_url="http://tellico-project.org/"
pkg_license=('GPL')
pkg_deps=('karchive' 'kcodecs' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'kcrash' 'kiconthemes'
         'kitemmodels' 'ki18n' 'kio' 'solid' 'kwidgetsaddons' 'kwindowsystem' 'kguiaddons' 'kxmlgui' 
         'kjobwidgets' 'kwallet' 'khtml' 'kfilemetadata' 'knewstuff' 'qimageblitz' 'libksane' 
         'taglib' 'libdiscid' 'poppler-qt5' 'v4l-utils' 'libkcddb5') # 'yaz' 'exempi' 
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://tellico-project.org/files/${pkg_name}-${_pkg_version}.tar.xz")
#pkg_source=("https://github.com/KDE/tellico/archive/${_commit}.zip")
pkg_shasum=('7f20d59485163a753b8ce4b773062857')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DENABLE_WEBCAM=TRUE

  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
