pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-graphicaleffects
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="A cross-platform application and UI framework, QtGraphicaleffects files"
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3' 'LGPL')
pkg_deps=('qt5-declarative')
pkg_build_deps=('qt5-tools')
groups=('qt5')
_pkgfqn="qtgraphicaleffects-opensource-src-${subver}"
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
    
    install -D -m644 LGPL_EXCEPTION.txt \
    ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LGPL_EXCEPTION.txt
}

