pkg_origin=cosmos

pkg_name=libgme
pkg_version=0.6.1
pkg_description="Video game music file emulation/playback library"
pkg_upstream_url="https://bitbucket.org/mpyne/game-music-emu/wiki/Home"
pkg_license=('LGPL')
pkg_deps=('gcc-libs')
pkg_build_deps=('cmake')
pkg_source=("https://bitbucket.org/mpyne/game-music-emu/downloads/game-music-emu-${pkg_version}.tar.bz2")
pkg_shasum=("d399f4a00aece2813e777dface2b6aab")

do_build() {
	mkdir build
	
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr
	make
}

do_package() {
	
	make DESTDIR=${pkg_prefix} install
}
