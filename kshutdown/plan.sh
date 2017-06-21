pkg_origin=

pkg_name=kshutdown
pkg_version=4.0.81
_pkg_version=source-4.1beta
pkg_description="Graphical shutdown utility that allows you to turn off or suspend a computer at a specified time."
pkg_upstream_url="http://kshutdown.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kdbusaddons' 'kglobalaccel' 'ki18n' 'kidletime' 'knotifications'
         'knotifyconfig' 'kxmlgui')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://sourceforge.net/projects/kshutdown/files/KShutdown/4.1%20Beta/kshutdown-${_pkg_version}.zip")
pkg_shasum=('8511b44c058d2334298ae4f1356c60c9')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-4.1beta \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKS_KF5=TRUE
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
