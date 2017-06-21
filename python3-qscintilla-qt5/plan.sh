pkg_origin=cosmos

pkg_name=python3-qscintilla-qt5
pkg_version=2.10
pkg_license=('GPL')
pkg_upstream_url="http://www.riverbankcomputing.co.uk/software/qscintilla/intro"
pkg_description="A port to Qt of Neil Hodgson's Scintilla C++ editor class, python3 bindings"
pkg_deps=('pyqt5-python3' 'qscintilla-qt5' 'qscintilla-designer-qt5')
pkg_build_deps=('chrpath')
pkg_source=("http://downloads.sourceforge.net/pyqt/QScintilla_gpl-${pkg_version}.tar.gz"
        'configure.patch')
pkg_shasum=('a61eb0d598b6787de18450574c2ad3b4'
         'd855b7393be8b72776c278a21a5e5601')

do_prepare() {

  #patch -p1 -i ${CACHE_PATH}/configure.patch
}

do_build() {
    
    python3 configure.py -n ../Qt4Qt5/ -o ../Qt4Qt5/ -c --pyqt=PyQt5 --qsci-libdir=/usr/lib --qmake /usr/lib/qt5/bin/qmake 
    make
}

do_package() {
    
    make DESTDIR=${CACHE_PATH} INSTALL_ROOT=${CACHE_PATH} install
}
