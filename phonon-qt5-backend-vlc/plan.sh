pkg_origin=cosmos

pkg_name=phonon-qt5-backend-vlc
_pkg_name=phonon-backend-vlc
pkg_version=0.9.1
pkg_description='Phonon VLC backend'
pkg_upstream_url='http://phonon.kde.org'
pkg_license=('LGPL')
pkg_deps=('vlc')
pkg_build_deps=('pkgconfig' 'extra-cmake-modules' 'mesa' 'phonon-qt5')
groups=('kde-complete' 'kde-uninstall')
pkg_source=("http://download.kde.org/stable/phonon/${_pkg_name}/${pkg_version}/${_pkg_name}-$pkg_version.tar.xz")
pkg_shasum=('5169203a485bf800bdc092e0b6efe646')

do_build() {
	mkdir -p build
	
	cmake ../${_pkg_name}-${pkg_version} \
		 -DCMAKE_BUILD_TYPE=Release \
		 -DCMAKE_INSTALL_PREFIX=/usr \
		 -DCMAKE_INSTALL_LIBDIR=lib \
		 -DPHONON_BUILD_PHONON4QT5=on
	make
}

do_package() {
	
	make DESTDIR=${pkg_prefix} install
} 
