# include global config
source qtkde.conf

pkg_origin=cosmos
pkg_name=('qt5-base')
pkg_version=${_qtver}
subver=${subver}
_pkgfqn="qtbase-opensource-src-${subver}"
pkg_description="A cross-platform application and UI framework"
pkg_deps=('core/sqlite' 'cosmos/xcb-util-keysyms' 'cosmos/xcb-util-wm' 'cosmos/xcb-util-image' 'cosmos/xcb-util-renderutil'
             'core/glib' 'dbus' 'core/fontconfig' 'xorg/libsm' 'libxrandr' 'libxv' 'libxi' 'unixodbc' 'libjpeg-turbo'
             'alsa-lib' 'xdg-utils' 'hicolor-icon-theme' 'desktop-file-utils' 'mesa' 'systemd'
             'libxcursor' 'xorg/libxrender' 'libpng' 'mariadb' 'icu' 'libgl' 'libxfixes' 'libxinerama'
             'libxkbcommon' 'libinput' 'harfbuzz' 'mtdev' 'libproxy' 'postgresql-libs')
pkg_upstream_url='http://qt-project.org/'
pkg_license=('GPL3' 'LGPL' 'FDL' 'custom')
pkg_source=("https://download.qt.io/archive/qt/${pkg_version}/${subver}/submodules/${_pkgfqn}.tar.xz"
            "https://github.com/qt/qtbase/commit/f45c6c180463ccb6620e1d273a264f14a1204a93.diff")
pkg_shasum=("267eb2af1a203c087f2113f43b08014d0e2d2cb269295b8602d869a2fad5296c"
            "60de1f41322347cd919cd379d0a2e646903eaab9a9c955cccff54b077924d816")
do_build() {

    cd $CACHE_PATH
    
    # fix dbus issues, shown mostly in QtCurve, patch will be in 5.9.1
    patch -p1 -i ${CACHE_PATH}/f45c6c180463ccb6620e1d273a264f14a1204a93.diff
    # don't place wayland session pop-ups all over
    patch -p1 -i ${CACHE_PATH}/qmenu.patch
    # windows destroyed, example in sddm kcm
    patch -p1 -i ${CACHE_PATH}/xcb.patch
    
    #sed -i 's|libs": "-lmysqlclient_r"|libs": "-lmariadb"|' src/sql/configure.json
    #sed -i 's|libs": "-lmysqlclient"|libs": "-lmariadb"|' src/sql/configure.json
    #sed -i 's|use_libmysqlclient_r|use_libmariadb|' src/sql/configure.json
        
    unset QTDIR
    export PATH="$PWD/qtbase/bin:$PWD/qtrepotools/bin:$PATH"

    ./configure -confirm-license -opensource \
                -prefix /usr \
                -bindir /usr/lib/qt5/bin \
                -headerdir /usr/include/qt5 \
                -archdatadir /usr/lib/qt5 \
                -docdir /usr/share/doc/qt5 \
                -plugindir /usr/lib/qt5/plugins \
                -importdir /usr/lib/qt5/imports \
                -qmldir /usr/lib/qt5/qml \
                -datadir /usr/share/qt5 \
                -testsdir /usr/share/qt5/tests \
                -translationdir /usr/share/qt5/translations \
                -sysconfdir /etc/xdg/qt5 \
                -examplesdir /usr/share/qt5/examples \
                -system-harfbuzz \
                -system-sqlite \
                -system-freetype \
                -openssl-linked \
                -nomake tests \
                -nomake examples \
                -optimized-qmake \
                -reduce-relocations \
                -dbus-linked \
                -feature-menu \
                -feature-textdate \
                -feature-ftp \
                -journald \
                -no-strip
                #-opengl es2
     make
     make docs
}


do_package() {

    
    cd ${CACHE_PATH}/${_pkgfqn}
    make $pkg_prefix=$pkg_prefix install
	
    cd ${CACHE_PATH}
    install -D -m644 ${_pkgfqn}/LGPL_EXCEPTION.txt \
    ${$pkg_prefix}/usr/share/licenses/qt5/LGPL_EXCEPTION.txt
    
    mkdir -p ${$pkg_prefix}/usr/bin
    for i in $(ls ${$pkg_prefix}/usr/lib/qt5/bin); do
        ln -s /usr/lib/qt5/bin/${i} ${$pkg_prefix}/usr/bin/${i}-qt5
    done
}
