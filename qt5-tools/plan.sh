pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-tools
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="A cross-platform application and UI framework, development tools and help files"
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3' 'LGPL' 'FDL' 'custom')
pkg_deps=('qt5-declarative' 'desktop-file-utils' 'qt5-location' 'hicolor-icon-theme' 'xdg-utils'
         'qt5-translations')
pkg_build_deps=('qt5-tools' 'qtwebkit-tp')
optpkg_deps=('qt5-doc: offline help documentation')
groups=('qt5')
_pkgfqn="qttools-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz"
#pkg_source=("https://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz"
        'assistant.desktop' 'designer.desktop' 'linguist.desktop')
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`
         '892d3632bdcd9a22f191aa8f28a3c0e1'
         '208921efc9e4c11fae762e9580ca23aa'
         '59cbeef3e6090dcb7d2a7d32cd62ea08')

do_build() {

    /usr/lib/qt5/bin/qmake # INCLUDEPATH="/usr/include/QtWebKit /usr/include/QtWebKitWidgets"
    make
    make docs
}

do_package() {
    make INSTALL_ROOT=$CACHE_PATH install
    make INSTALL_ROOT=$CACHE_PATH install_docs
	
    install -d ${CACHE_PATH}/usr/share/applications
    install -m644 ${CACHE_PATH}/assistant.desktop ${CACHE_PATH}/usr/share/applications/
    install -m644 ${CACHE_PATH}/designer.desktop ${CACHE_PATH}/usr/share/applications/
    install -m644 ${CACHE_PATH}/linguist.desktop ${CACHE_PATH}/usr/share/applications/
    
    mkdir -p ${CACHE_PATH}/usr/bin
    for i in $(ls ${CACHE_PATH}/usr/lib/qt5/bin); do
        ln -s /usr/lib/qt5/bin/${i} ${CACHE_PATH}/usr/bin/${i}-qt5
    done
    
    install -D -m644 LICENSE.LGPL3 ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.LGPL3
}

