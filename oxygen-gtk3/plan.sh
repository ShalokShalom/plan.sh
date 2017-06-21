pkg_origin=

pkg_name=oxygen-gtk3
pkg_version=1.4.1.1
_commit=705b755f67b50213ec596a51b8cfabf2780bc24b
pkg_description="The Oxygen engine for GTK3, for better Qt/GKT+ integration."
pkg_upstream_url=("https://github.com/KDE/oxygen-gtk")
pkg_license=('LGPL3' 'GPL')
pkg_deps=('cairo' 'dbus-glib')
pkg_build_deps=('cmake' 'gtk3' 'gtk2')
pkg_source=("https://github.com/KDE/oxygen-gtk/archive/${_commit}.zip")
pkg_shasum=('bebfedf79ce5507b405f73e4852eb16b')

do_build() {
	mkdir -p build 
	cd build
	
	cmake ../oxygen-gtk-${_commit} \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_SKIP_RPATH=ON \
        -DCMAKE_INSTALL_PREFIX=/usr  
	make
}

do_package() {
	cd build
	
	make DESTDIR=${pkg_prefix} install
}
