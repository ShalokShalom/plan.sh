pkg_origin=

pkg_name=kf5trans
pkg_version=1.3
pkg_description="Transitional KDE 4 to kf5 package"
pkg_upstream_url="http://kaosx.us/"
pkg_license=('GPL')
pkg_deps=('qt5-base' 'xterm')
install=kf5trans.install
pkg_source=("kf5trans.tar.gz"
        'kdeglobals'
        'ksplashrc'
        'libre.sh'
        'plasma-org.kde.plasma.desktop-appletsrc'
        'plasmarc'
        'plasmashellrc'
        'stylerc')
pkg_shasum=('abde3fa2f8865abd98829dc5f8691a92'
         '8ca968e7f09201b8d2376d131a8e55df'
         'd1958a1b026c28b0490e5d71e96f24ca'
         'c0b853a2de32c6fefff417bc747d0b8a'
         '864fd727733ae15355b98390635ea52b'
         'b2af54273aa39054a97f4ccfc8a4db95'
         '0d98fc1af5c60564c638fa2b36b8a9bd'
         'c67bc73a3cade9af3a8f1dca6bbc6ab2')

do_build() {
    cd "${CACHE_PATH}/kf5trans/"
   
    /usr/lib/qt5/bin/qmake kf5trans.pro
    make clean
    make
}

do_package() {
    cd "${CACHE_PATH}/kf5trans/"
    make INSTALL_ROOT="$pkg_prefix/" install
    
    mkdir -p ${pkg_prefix}/opt/xdg
    install -m644 -p ${CACHE_PATH}/kdeglobals ${pkg_prefix}/opt/xdg
    install -m644 -p ${CACHE_PATH}/ksplashrc ${pkg_prefix}/opt/xdg
    install -m644 -p ${CACHE_PATH}/plasma-org.kde.plasma.desktop-appletsrc ${pkg_prefix}/opt/xdg
    install -m644 -p ${CACHE_PATH}/plasmarc ${pkg_prefix}/opt/xdg
    install -m644 -p ${CACHE_PATH}/plasmashellrc ${pkg_prefix}/opt/xdg
    install -m644 -p ${CACHE_PATH}/libre.sh ${pkg_prefix}/opt/xdg
    install -m644 -p ${CACHE_PATH}/stylerc ${pkg_prefix}/opt/xdg
}
