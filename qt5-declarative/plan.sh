pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=('qt5-declarative' 'qt5-declarative-docs')
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3' 'LGPL' 'FDL' 'custom')
pkg_build_deps=('qt5-xmlpatterns' 'mesa' 'python2' 'qt5-tools')
_pkgfqn="qtdeclarative-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
#pkg_source=("https://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`)

do_build() {
    #patch -p1 -i $CACHE_PATH/0001-Scene-Graph-Fixed-memory-leak-in-QSGBatchRenderer-Re.patch

    /usr/lib/qt5/bin/qmake
    make
    make docs
}

package_qt5-declarative() {
    pkg_description="A cross-platform application and UI framework, QtDeclarative files"
    pkg_deps=('qt5-xmlpatterns' 'mesa')
    groups=('qt5')
    
    make INSTALL_ROOT=$CACHE_PATH install
    
    mkdir -p ${CACHE_PATH}/usr/bin
    for i in $(ls ${CACHE_PATH}/usr/lib/qt5/bin); do
        ln -s /usr/lib/qt5/bin/${i} ${CACHE_PATH}/usr/bin/${i}-qt5
    done
}

package_qt5-declarative-docs() {
    pkg_description="Documentation files for QtDeclarative"
    pkg_deps=('qt5-base')
    groups=('qt5-docs')
    
    make INSTALL_ROOT=$CACHE_PATH install_docs
}
