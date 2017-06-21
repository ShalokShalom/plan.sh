pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-multimedia
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="A cross-platform application and UI framework, QtMultimedia files"
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3' 'LGPL' 'FDL' 'custom')
pkg_deps=('qt5-declarative' 'openal' 'libxslt' 'libxcomposite' 'gst-plugins-base'
         'gst-plugins-good' 'gst-plugins-bad' 'pulseaudio')
groups=('qt5')
_pkgfqn="qtmultimedia-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
#pkg_source=("https://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`)

do_build() {

    /usr/lib/qt5/bin/qmake GST_VERSION=1.0
    make
}

do_package() {
    make INSTALL_ROOT=$CACHE_PATH install
    
    mkdir -p ${CACHE_PATH}/usr/bin
    for i in $(ls ${CACHE_PATH}/usr/lib/qt5/bin); do
        ln -s /usr/lib/qt5/bin/${i} ${CACHE_PATH}/usr/bin/${i}-qt5
    done
    
    install -D -m644 LICENSE.LGPL3 ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.LGPL3
}

