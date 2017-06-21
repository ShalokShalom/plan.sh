pkg_origin=

pkg_name=appmenu-qt
appname=appmenu-qt
pkgbranch=trunk
pkg_version=0.2.6
pkg_description="Application menu module for Qt"
pkg_upstream_url="https://launchpad.net/appmenu-qt"
pkg_license=('GPL')
pkg_deps=('libdbusmenu-qt')
pkg_build_deps=('cmake' 'automoc4')
pkg_source=("http://launchpad.net/${appname}/${pkgbranch}/${pkg_version}/+download/${appname}-${pkg_version}.tar.bz2"
        'appmenu.diff')
pkg_shasum=('90cce750e5412d43ce075b0a9bdb6782'
         '8aa185359143d5f0d6a00888694f559d')

do_build() {
    cd "${CACHE_PATH}/${appname}-${pkg_version}"
    # bug https://bugs.launchpad.net/appmenu-qt/+bug/1096008
    patch -p0 -i "${CACHE_PATH}"/appmenu.diff
    
    cmake . -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix`
    make
}

do_package() {
    cd "${CACHE_PATH}/${appname}-${pkg_version}"
    
    make DESTDIR="${pkg_prefix}" install
}
