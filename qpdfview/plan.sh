pkg_origin=

pkg_name=qpdfview
pkg_version=0.4.16.80
_pkg_version=0.4.17beta1
pkg_description='Tabbed document viewer using Poppler, libspectre, DjVuLibre, CUPS and Qt'
pkg_upstream_url='https://launchpad.net/qpdfview'
pkg_license=('GPL2')
pkg_deps=('desktop-file-utils' 'djvulibre' 'hicolor-icon-theme' 'libcups' 'libspectre' 
         'poppler-qt5' 'qt5-svg' 'texlive-bin')
pkg_build_deps=('qt5-tools')
#conflicts=('okular')
#replaces=('okular')
pkg_source=("https://launchpad.net/qpdfview/trunk/${_pkg_version}/+download/${pkg_name}-${_pkg_version}.tar.gz")
pkg_shasum=('c203518a8988203dd94c648490089a8e')

do_build() {
  cd ${pkg_name}-${_pkg_version}

  /usr/lib/qt5/bin/lrelease qpdfview.pro
  /usr/lib/qt5/bin/qmake qpdfview.pro
  make
}

do_package() {
  cd ${pkg_name}-${_pkg_version}

  make INSTALL_ROOT=${pkg_prefix} install
}
