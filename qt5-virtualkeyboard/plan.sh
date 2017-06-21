pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-virtualkeyboard
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="Virtual keyboard framework that consists of a C++ backend as well as a UI frontend implemented in QML."
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3')
pkg_deps=('hunspell' 'qt5-declarative' 'qt5-svg')
groups=('qt5')
_pkgfqn="qtvirtualkeyboard-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/${_pkgfqn}.tar.xz"
        'virtualkeyboard.desktop')
#pkg_source=("https://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`
         'd5f233aa149751819c2e8dfcd2fc13e2')

do_build() {

    /usr/lib/qt5/bin/qmake CONFIG+="lang-all handwriting"
    make
    
    /usr/lib/qt5/bin/qmake
    make
}

do_package() {
    make INSTALL_ROOT=$CACHE_PATH install
    
    install -D -m644 LICENSE.GPL3 ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.GPL3
    # install a QML example
    install -D -m755 examples/virtualkeyboard/basic/basic ${CACHE_PATH}/usr/bin/basic
    install -D -m644 ${CACHE_PATH}/virtualkeyboard.desktop ${CACHE_PATH}/usr/share/applications/virtualkeyboard.desktop
    
}

