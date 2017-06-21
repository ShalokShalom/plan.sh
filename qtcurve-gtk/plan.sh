pkg_origin=

pkg_name=qtcurve-gtk
_pkg_name=qtcurve
pkg_version=1.8.18.15
_commit=c0018df44efe55d40a5dda9e937e7b5aa6839b08
pkg_license=('GPL')
pkg_description='The QtCurve style engine for GTK.'
pkg_upstream_url='https://projects.kde.org/projects/playground/base/qtcurve'
pkg_deps=('qtcurve' 'gtk2')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://github.com/KDE/qtcurve/archive/${_commit}.zip"
        'kdeglobals')
pkg_shasum=('55af33127225aac2a1ee215b3df37859'
         '8ca968e7f09201b8d2376d131a8e55df')

do_build() {
	mkdir -p build
	cd build
	
	cmake ../${_pkg_name}-${_commit} \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DENABLE_GTK2=true \
        -DQTC_QT5_ENABLE_KDE=false \
        -DQTC_QT4_ENABLE_KDE=false \
        -DENABLE_QT5=false \
        -DENABLE_QT4=false
	make
}

do_package() {
	cd build
	make DESTDIR=${pkg_prefix} install
	
	rm -r ${pkg_prefix}/usr/lib/libqtcurve-utils.so*
	rm -r ${pkg_prefix}/usr/share/themes/QtCurve/gtk-2.0/kdeglobals
	install -D -m644 ${CACHE_PATH}/kdeglobals ${pkg_prefix}/usr/share/themes/QtCurve/gtk-2.0/
}
