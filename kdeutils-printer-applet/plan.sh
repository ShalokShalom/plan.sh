pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name="kdeutils-printer-applet"
_pkg_name="printer-applet"
pkg_version=${_kdever}
pkg_description="A system tray utility that shows current print jobs, printer warnings and errors"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kde-runtime' 'kde-baseapps' 'kdepim-libs' 'kdebindings-pykde4' 'system-config-printer')
install=kdeutils.install
pkg_build_deps=('pkg-config' 'cmake' 'automoc4')

pkg_source=($_mirror/${_pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
	cd ${CACHE_PATH}/${_pkg_name}-${pkg_version}

	msg "starting build ..."
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DINSTALL_PRINTER_APPLET=TRUE \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'

	make
}

do_package() {
	cd ${CACHE_PATH}/${_pkg_name}-${pkg_version}
	
	make DESTDIR=${pkg_prefix} install
}
