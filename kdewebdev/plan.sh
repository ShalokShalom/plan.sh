pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkgbase=('kdewebdev')
pkg_name=('kdewebdev-kfilereplace'
         'kdewebdev-kimagemapeditor'
         'kdewebdev-kommander'
         'kdewebdev-klinkstatus')

pkg_version=${_kdever}

pkg_description="split package"
pkg_upstream_url="http://www.kde.org/"
pkg_license=('GPL' 'LGPL' 'FDL')


pkg_build_deps=('pkgconfig' 'cmake' 'automoc4' 'ruby' 'kdepimlibs' 'boost' 'kde-runtime' 'tidyhtml' 
             'kdepim-runtime')

pkg_source=($_mirror/${pkgbase}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkgbase}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)



do_build() {
	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}

	msg "starting build ..."
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_SKIP_RPATH=ON \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'

	make
}

package_kdewebdev-kfilereplace() {
	pkg_description="Utility that replace some strings with others in a lot of files in an only operation"
	pkg_deps=('kde-runtime')
	groups=("kde" "${pkgbase}" 'kde-uninstall')
	groups=('utils')
	conflicts=('kdewebdev-common' 'kdewebdev-doc')
	install=${pkgbase}.install

	splitdirs="kfilereplace doc/kfilereplace"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install
		done
}

package_kdewebdev-kimagemapeditor() {
	pkg_description="Image map editor"
	pkg_deps=('kde-runtime')
        conflicts=('kdewebdev-common' 'kdewebdev-doc')
	groups=("kde" "${pkgbase}" 'kde-uninstall')
	groups=('graphics')
	install=${pkgbase}.install

	splitdirs="kimagemapeditor doc/kimagemapeditor"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install
		done
}

package_kdewebdev-kommander() {
	pkg_description="Kommander, the visual application builder"
	pkg_deps=('kde-runtime')
        conflicts=('kdewebdev-common' 'kdewebdev-doc')
	groups=("kde" "${pkgbase}" 'kde-uninstall')
	groups=('programming')
	install=${pkgbase}.install

	splitdirs="kommander" # FIXME: doc/kommander
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install
		done
}

package_kdewebdev-klinkstatus() {
	pkg_description="A Link checker utility"
	pkg_deps=('kde-runtime' 'tidyhtml' 'kdepimlibs') 
        conflicts=('kdewebdev-common' 'kdewebdev-doc')
	groups=("kde" "${pkgbase}" 'kde-uninstall')
	groups=('utils')
	install=${pkgbase}.install

	splitdirs="klinkstatus doc/klinkstatus"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install
		done
}
