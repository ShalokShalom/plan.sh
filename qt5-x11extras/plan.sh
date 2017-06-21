pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-x11extras
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="A cross-platform application and UI framework, Qt11extras"
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3' 'LGPL')
pkg_deps=('qt5-declarative')
groups=('qt5')
_pkgfqn="qtx11extras-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
#pkg_source=("https://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`)

do_build() {

    /usr/lib/qt5/bin/qmake
    make
}

do_package() {
    make INSTALL_ROOT=$CACHE_PATH install
    
    install -D -m644 LGPL_EXCEPTION.txt \
    ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LGPL_EXCEPTION.txt
}

