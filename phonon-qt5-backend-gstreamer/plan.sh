pkg_origin=cosmos

pkg_name=phonon-qt5-backend-gstreamer
_pkg_name=phonon-backend-gstreamer
pkg_version=4.9.0
pkg_description="Phonon GStreamer backend Qt5 version"
pkg_upstream_url='http://phonon.kde.org'
pkg_license=('LGPL')
pkg_deps=('gst-plugins-base' 'qt5-x11extras')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'mesa' 'phonon-qt5')
groups=('kde-complete' 'kde-uninstall')
pkg_source=("http://download.kde.org/stable/phonon/${_pkg_name}/${pkg_version}/${_pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("git://anongit.kde.org/phonon-gstreamer#branch=1.0-porting-for-merge")
pkg_shasum=('b2b0ca327908948ce8cdba117e31bf80')

do_build() { 
	mkdir -p build
	
	cmake ../phonon-gstreamer-${pkg_version} \
		 -DCMAKE_BUILD_TYPE=Release \
		 -DCMAKE_INSTALL_PREFIX=/usr \
		 -DCMAKE_INSTALL_LIBDIR=lib \
		 -DPHONON_BUILD_PHONON4QT5=on
	make
}

do_package() {
	
	make DESTDIR=${pkg_prefix} install
}
