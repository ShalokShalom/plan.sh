pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdegraphics-strigi-analyzer
pkg_version=${_kdever}
pkg_description="Strigi analyzers for various graphics file formats"
pkg_upstream_url='http://www.kde.org'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kdelibs' 'strigi')
pkg_build_deps=('pkg-config' 'cmake' 'automoc4')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
	cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
	
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
                -DCMAKE_INSTALL_PREFIX=${_installprefix} \
                -DCMAKE_SKIP_RPATH=ON \
                -DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'

}

do_package() {
	cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
	
	make DESTDIR=${pkg_prefix} install
}
