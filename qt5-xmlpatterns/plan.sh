pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-xmlpatterns
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="A cross-platform application and UI framework, QtXmlPatterns files"
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3' 'LGPL')
pkg_deps=('qt5-base')
pkg_build_deps=('qt5-tools')
groups=('qt5')
_pkgfqn="qtxmlpatterns-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
#pkg_source=("https://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`)

do_build() {

    /usr/lib/qt5/bin/qmake
    make
    make docs
}

do_package() {
    make INSTALL_ROOT=$CACHE_PATH install
    make INSTALL_ROOT=$CACHE_PATH install_docs
    
    mkdir -p ${CACHE_PATH}/usr/bin
    for i in $(ls ${CACHE_PATH}/usr/lib/qt5/bin); do
        ln -s /usr/lib/qt5/bin/${i} ${CACHE_PATH}/usr/bin/${i}-qt5
    done
    
    install -D -m644 LGPL_EXCEPTION.txt \
    ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LGPL_EXCEPTION.txt
}

