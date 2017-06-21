pkg_origin=cosmos

pkg_name=mpd
pkg_version=0.20.9
_pkg_version=0.20
pkg_description="Music daemon that plays MP3, FLAC, and Ogg Vorbis files"
pkg_license=('GPL')
pkg_upstream_url="https://www.musicpd.org/"
pkg_deps=('libao' 'ffmpeg' 'libmodplug' 'audiofile' 'libshout' 'libmad' 'curl' 'faad2'
         'sqlite' 'jack' 'libmms' 'wavpack' 'avahi' 'libid3tag' 'libmpdclient'
         'pulseaudio' 'mpg123' 'yajl' 'sdl_sound' 'libcdio-paranoia' 'fluidsynth' 'boost-libs'
         'libsoxr' 'libnfs' 'zziplib' 'zip' 'libupnp' 'libgme' 'opus')
pkg_build_deps=('boost' 'xmlto') #'doxygen' 
install=${pkg_name}.install
backup=('etc/mpd.conf')
pkg_source=("https://www.musicpd.org/download/mpd/${_pkg_version}/mpd-${pkg_version}.tar.xz"
        'tmpfiles.d'
        'conf')
pkg_shasum=('3eeb559a856d2b5de468a8b713967202'
         'e5cdccd201610a41e957d684ebc38985'
         'ca16fc9ce20ca382b620cd366c95647e')

do_build() {

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --enable-jack \
    --enable-pulse \
    --enable-libmpdclient \
    --disable-documentation \
    --enable-pipe-output \
    --disable-libwrap \
    --disable-sidplay \
    --enable-zzip \
    --with-systemdsystemunitdir=/usr/lib/systemd/system \
    --with-systemduserunitdir=/usr/lib/systemd/user
  make
}

do_package() {
   make DESTDIR=${pkg_prefix} install
   
   install -Dm644 ../conf ${pkg_prefix}/etc/mpd.conf
   install -Dm644 ../tmpfiles.d ${pkg_prefix}/usr/lib/tmpfiles.d/mpd.conf
   install -d -g 45 -o 45 ${pkg_prefix}/var/lib/mpd/playlists
}
