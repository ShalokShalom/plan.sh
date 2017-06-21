pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name="kdeutils-superkaramba"
_pkg_name="superkaramba"
pkg_version=${_kdever}
pkg_description="Desktop widgets"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('qimageblitz' 'python2' 'kdelibs')
install=kdeutils.install
pkg_build_deps=('pkg-config' 'cmake' 'automoc4')

pkg_source=($_mirror/${_pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
	cd ${CACHE_PATH}/${_pkg_name}-${pkg_version}

	msg "starting build ..."
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_SKIP_RPATH=ON \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'
	make
}

do_package() {
	cd ${CACHE_PATH}/${_pkg_name}-${pkg_version}
	
	make DESTDIR=${pkg_prefix} install
}
