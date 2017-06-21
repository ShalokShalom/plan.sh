pkg_origin=

pkg_name=qupzilla
pkg_version=2.1.90
_commit=d6b142b
pkg_description="A fast open source browser based on QtWebengine, written in Qt Framework"
pkg_upstream_url="http://www.qupzilla.com/"
pkg_license=('GPL')
pkg_deps=('qtwebengine' 'mesa' 'desktop-file-utils' 'hicolor-icon-theme' 'qt5-x11extras')  
pkg_build_deps=('gdb' 'qt5-tools')
pkg_source=("https://github.com/QupZilla/QupZilla/tarball/master/QupZilla-qupzilla-${pkg_version}.tar.gz"
        'speeddial.diff'
        'preferences.diff'
        'browserwindow.diff'
        'defines.diff'
        'bookmarks_json_new.diff')
pkg_shasum=('20747ffa03664f0786af385ce85f23c8'
         '62545f0463522b76ad1c29db50272f71'
         '65337a0fb92c5c3222d72969771388ce'
         '0a1a394a6cd9aaff40d2129203cb5479'
         'f5207fdb5455567352fbabb63f36f731'
         'fcf6d493c49e07c1330719ff72eaaba6')

do_build() {
    cd QupZilla-qupzilla-${_commit}/
    patch -p0 -i ${CACHE_PATH}/speeddial.diff
    patch -p0 -i ${CACHE_PATH}/preferences.diff
    patch -p0 -i ${CACHE_PATH}/browserwindow.diff
    #patch -p0 -i ${CACHE_PATH}/defines.diff
    patch -p0 -i ${CACHE_PATH}/bookmarks_json_new.diff

    export USE_WEBGL="true"
    #export NO_X11="true"
   
    /usr/lib/qt5/bin/qmake 
    make
}

do_package() {
    cd QupZilla-qupzilla-${_commit}/
    make INSTALL_ROOT=${pkg_prefix}/ install
    
    cp ${pkg_prefix}/usr/share/qupzilla/locale/de_DE.qm ${pkg_prefix}/usr/share/qupzilla/locale/de_CH.qm
    cp ${pkg_prefix}/usr/share/qupzilla/locale/de_DE.qm ${pkg_prefix}/usr/share/qupzilla/locale/de_AT.qm
    #cp ${pkg_prefix}/usr/share/qupzilla/locale/es_ES.qm ${pkg_prefix}/usr/share/qupzilla/locale/es_AR.qm
}
