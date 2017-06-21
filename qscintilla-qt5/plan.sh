pkg_origin=cosmos

pkg_name=qscintilla-qt5
pkg_version=2.10
pkg_license=('GPL')
pkg_upstream_url="http://www.riverbankcomputing.co.uk/software/qscintilla/intro"
pkg_description="A port to Qt of Neil Hodgson's Scintilla C++ editor class"
pkg_deps=('qt5-base')
pkg_build_deps=('chrpath' 'qt5-tools')
pkg_source=("https://downloads.sourceforge.net/pyqt/QScintilla_gpl-${pkg_version}.tar.gz"
        'qt5_libname.patch')
pkg_shasum=('a61eb0d598b6787de18450574c2ad3b4'
         'c6945e86d8eaf3b1985974f23dfbf057')

do_prepare() {

    #patch -p1 -i ${CACHE_PATH}/qt5_libname.patch
}

do_build() {

    /usr/lib/qt5/bin/qmake qscintilla.pro
    make
}

do_package() {
    
    make DESTDIR=${CACHE_PATH} INSTALL_ROOT=${CACHE_PATH} install
}

