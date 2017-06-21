pkg_origin=cosmos

pkg_name=mpv
pkg_version=0.25.0
pkg_description='Video player based on MPlayer/mplayer2'
pkg_license=('GPL')
pkg_upstream_url='http://mpv.io'
pkg_deps=('ffmpeg' 'lcms2' 'libdvdread' 'libcdio-paranoia' 'libgl' 'libxinerama'
         'libxv' 'libxkbcommon' 'libva' 'wayland' 'desktop-file-utils' 'hicolor-icon-theme'
         'xdg-utils' 'libdvdnav' 'youtube-dl' 'libass' 'libbluray' 'lua' 'libxrandr' 'jack'
         'rubberband' 'samba' 'libxss' 'libcaca')
pkg_build_deps=('mesa' 'python2-docutils' 'ladspa' 'perl')
pkg_source=("https://github.com/mpv-player/mpv/archive/v${pkg_version}.tar.gz"
        "https://github.com/mpv-player/mpv/commit/5053f4cc3f48538c3d9a3ba13dc98442f3302052.patch")
#pkg_source=("https://github.com/mpv-player/mpv/archive/${_commit}.zip")
pkg_shasum=('73b3d233c3b4428d0cfd5491c5cb6c41'
         '0e0c367e20d4c821db4456fb01f5bc71')

prepare() {
    # https://github.com/mpv-player/mpv/issues/2729
    #patch -p1 -i ${CACHE_PATH}/5053f4cc3f48538c3d9a3ba13dc98442f3302052.patch

    ./bootstrap.py
}

do_build() {

    ./waf configure --prefix=/usr \
	--confdir=/etc/mpv \
	--enable-libmpv-shared \
	--enable-cdda \
	--enable-sdl2 \
	--enable-zsh-comp \
	--enable-libarchive \
	--enable-dvdnav \
	--enable-dvdread \
	--enable-libbluray \
	--enable-cdda
		
    ./waf build
}

do_package() {
    ./waf install --destdir=${pkg_prefix}

    install -m644 DOCS/{encoding.rst,tech-overview.txt} ${pkg_prefix}/usr/share/doc/mpv
}
