pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-websockets
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="Web-based protocol designed to enable two-way communication between a client application and a remote host."
pkg_upstream_url='https://github.com/qt/qtwebsockets'
pkg_license=('GPL3' 'LGPL')
pkg_deps=('qt5-declarative')
pkg_build_deps=('python2')
groups=('qt5')
_pkgfqn="qtwebsockets-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/${_pkgfqn}.tar.xz")
#pkg_source=("https://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/${_pkgfqn}.tar.xz")
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`)

do_build() {

    /usr/lib/qt5/bin/qmake
    make
}

do_package() {
    
    make INSTALL_ROOT=${CACHE_PATH} install
}

