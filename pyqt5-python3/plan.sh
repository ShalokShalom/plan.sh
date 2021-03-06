pkg_origin=cosmos

pkg_name=pyqt5-python3
pkg_version=5.8.2
_snapshot=dev1604260930
pkg_description="A set of Python3 bindings for the Qt toolkit"
pkg_upstream_url="http://riverbankcomputing.co.uk/software/pyqt/intro"
pkg_license=('GPL')
pkg_deps=('sip3' 'dbus-python3' 'qt5-multimedia' 'qt5-serialport' 'qt5-svg' 'qtwebkit-tp' 'qtwebengine')
pkg_build_deps=('qt5-tools')
pkg_source=("https://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-${pkg_version}/PyQt5_gpl-${pkg_version}.tar.gz")
#pkg_source=("https://www.riverbankcomputing.com/static/Downloads/PyQt5/PyQt5_gpl-5.6.1.${_snapshot}.tar.gz")
pkg_shasum=('c3048e9d242f3e72fd393630da1d971a')

do_build() {

  python3 configure.py \
    --confirm-license \
    --qsci-api \
    -q /usr/lib/qt5/bin/qmake \
    --designer-plugindir /usr/lib/qt5/plugins/designer 

  #find -name 'Makefile' | xargs sed -i 's|-Wl,-rpath,/usr/lib||g;s|-Wl,-rpath,.* ||g'

  make
}

do_package(){
  # INSTALL_ROOT is needed for the QtDesigner module, the other Makefiles use DESTDIR
  make DESTDIR=${CACHE_PATH} INSTALL_ROOT=${CACHE_PATH} install
}
