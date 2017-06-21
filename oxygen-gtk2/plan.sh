pkg_origin=

pkg_name=oxygen-gtk2
pkg_version=1.4.6
pkg_description="The Oxygen engine for GTK2, for better Qt/GKT+ integration."
pkg_upstream_url=("https://github.com/KDE/oxygen-gtk")
pkg_license=('LGPL3' 'GPL')
pkg_deps=('cairo')
pkg_build_deps=('gcc' 'cmake' 'gtk2')
pkg_source=("http://download.kde.org/stable/${pkg_name}/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.bz2"
        'kdeglobals')
pkg_shasum=('493892fc36302bfe862604f667a6c04e'
         'feadfd1d24392778da98b992cf3b186a')

do_build() {
	cd ${pkg_name}-${pkg_version}
	mkdir -p build
	
	cd build
	cmake -DCMAKE_BUILD_TYPE=Release \
	      -DCMAKE_SKIP_RPATH=ON \
	      -DCMAKE_INSTALL_PREFIX=/usr .. 
	make
}

do_package() {
	cd ${pkg_name}-${pkg_version}/build
	make DESTDIR=${pkg_prefix} install
	# kf5 colors/theme are not picked up
	rm -r ${pkg_prefix}/usr/share/themes/oxygen-gtk/gtk-2.0/kdeglobals
	install -D -m644 ${CACHE_PATH}/kdeglobals ${pkg_prefix}/usr/share/themes/oxygen-gtk/gtk-2.0/
}
