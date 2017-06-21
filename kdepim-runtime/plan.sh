pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdepim-runtime
pkg_version=${_kdever}
pkg_description="KDE Pim Runtime"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('akonadi-mime' 'akonadi-notes' 'akonadi-contacts' 'knotifyconfig' 'knewstuff' 'kcmutils'
         'kdelibs4support' 'kconfig' 'kio' 'kitemmodels' 'kcodecs' 'accountsqt' 'signonqt' 'shared-mime-info' 
         'akonadi' 'kmime' 'kmailtransport' 'kidentitymanagement' 'kcontacts' 'kalarmcal' 'kcalcore' 
         'kcalutils' 'kmbox' 'kimap' 'syndication' 'akonadi-calendar' 'kaccounts-integration'
         'kdav' 'libkgapi' 'libkolab' 'qtwebkit-tp') # not used 'libkfbapi' disable 'qtspeech', might cause crashes
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
    cd ${pkg_name}-${pkg_version}
    # Fix migration to new Gmail authentication
    #patch -p1 -i ${CACHE_PATH}/c9ae16363e68d6958db0cd835cb0180b340594b5.diff
    #sed -i -e 's/Libkolabxml 1.2 QUIET/Libkolabxml 1.1 QUIET/' resources/CMakeLists.txt
}

do_build() {    
    mkdir -p build
    cd build

    cmake ../${pkg_name}-${pkg_version} \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_SKIP_RPATH=ON \
        -DKDE_INSTALL_LIBDIR=lib \
        -DKDE_INSTALL_SYSCONFDIR=/etc \
        -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
        -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DBUILD_TESTING=OFF
    make
}

do_package() {
    cd build

    make DESTDIR=${pkg_prefix} install
}
