pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=juk
pkg_version=${_kdever}
pkg_description='A jukebox, tagger and music collection manager'
pkg_upstream_url='http://kde.org/applications/multimedia/juk/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kdelibs' 'taglib')
pkg_build_deps=('cmake' 'automoc4')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)


do_build() {
	cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
	
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
                -DCMAKE_INSTALL_PREFIX=${_installprefix} \
                -DCMAKE_SKIP_RPATH=ON \
		-DWITH_TunePimp=OFF \
                -DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'
	make
}

do_package() {
	cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
	
	make DESTDIR=${pkg_prefix} install
}

