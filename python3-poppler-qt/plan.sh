pkg_origin=cosmos

pkg_name=python3-poppler-qt
_pkg_name=python-poppler-qt5
pkg_version=0.25.0
pkg_description="A Python 3 binding to poppler-qt, early Qt 5 port"
pkg_upstream_url="https://github.com/wbsoft/python-poppler-qt5/"
pkg_license=('LGPL')
pkg_deps=('pyqt5-python3' 'poppler-qt5' 'python3')
pkg_build_deps=('pkg-config')
#pkg_source=("https://github.com/wbsoft/${_pkg_name}/archive/v${pkg_version}.tar.gz")
pkg_source=("https://github.com/zehome/python-poppler-qt5/archive/v${pkg_version}.tar.gz")
pkg_shasum=('775b8a3623619f23515aee61aa6d6bab')
 
do_build() {
        
    CFLAGS="-std=c++11" python3 setup.py build_ext --qmake-bin='/usr/lib/qt5/bin/qmake' \
                               --pyqt-sip-dir='/usr/share/sip/PyQt5'
}
 
do_package() {
        
    python3 setup.py install --root=${CACHE_PATH} build_ext --qmake-bin='/usr/lib/qt5/bin/qmake'
}
