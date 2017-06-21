pkg_origin=

pkg_name=minitube
pkg_version=2.4
pkg_description="A native YouTube client in QT. Watch YouTube videos without Flash Player"
pkg_upstream_url="http://flavio.tordini.org/minitube"
pkg_license=('GPL')
pkg_deps=('phonon-backend-vlc' 'phonon' 'qt')
install=minitube.install
pkg_source=("https://github.com/flaviotordini/minitube/archive/${pkg_version}.tar.gz"
        'locale.diff')
pkg_shasum=('90e8f7c8adfe633553e08d98edd77961'
         '61ebe0b289e63790a70388d49cec205e')

do_build() {
        cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
        #patch -p0 -i "${CACHE_PATH}/locale.diff"
        
        qmake 
        make
}

do_package() {
        cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
        
        make install INSTALL_ROOT="${pkg_prefix}" 
}
