pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkgbase=('kdetoys')
pkg_name=('kdetoys-amor'
         'kdetoys-kteatime'
         'kdetoys-ktux')
pkg_version=${_kdever}
pkg_description="split package"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_build_deps=('pkgconfig' 'cmake' 'automoc4' "kde-workspace>=${_kdever}")
pkg_source=($_mirror/${pkgbase}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkgbase}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}

        # build it
	msg "starting build ..."
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_SKIP_RPATH=ON \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'

	make 
}

package_kdetoys-amor() {
	pkg_description="Amusing Misuse Of Resources puts comic figures above your windows"
	conflicts=("kdetoys-common" "kdetoys-doc")
	groups=("kde" "kdetoys" "kde-uninstall" 'accessories')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/amor
	make DESTDIR=${pkg_prefix} install 
}

package_kdetoys-kteatime() {
	pkg_description="System tray applet that makes sure your tea doesn't get too strong"
	conflicts=("kdetoys-common" "kdetoys-doc")
	groups=("kde" "kdetoys" "kde-uninstall" 'accessories')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kteatime
	make DESTDIR=${pkg_prefix} install 
}

package_kdetoys-ktux() {
	pkg_description="Tux-in-a-Spaceship screen saver"
	conflicts=("kdetoys-common")
	groups=("kde" "kdetoys" "kde-uninstall" 'accessories')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/ktux
	make DESTDIR=${pkg_prefix} install 
}

