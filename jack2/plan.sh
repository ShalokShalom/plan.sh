pkg_origin=cosmos

pkg_name=jack2
pkg_version=1.9.10
_commit=ce825c6
pkg_description="The next-generation JACK with SMP support"
pkg_upstream_url="http://jackaudio.org/"
backup=(etc/security/limits.d/99-audio.conf)
pkg_license=('GPL')
pkg_deps=('libsamplerate' 'celt' 'libffado' 'dbus' 'opus' 'dbus-python2' 'portaudio-svn')
pkg_build_deps=('python2' 'doxygen')
pkg_deps=('dbus-python2: jack_control')
pkg_source=("https://github.com/jackaudio/jack2/archive/v${pkg_version}.tar.gz"
        '99-audio.conf'
        '40-hpet-permissions.rules')
pkg_shasum=('2db990e7c09e4cc163f40add01f6867d'
         '4d928a76e3f3d77d037c42ab75ac0f0b'
         '23eba69d2dbbb800f68176e5d38b9af5')

do_build() {
  # fix doxygen dir
  sed -i 's|build/default/html|html|' wscript
  
  LDFLAGS="$LDFLAGS,--no-as-needed -lm" python2 ./waf configure \
    --prefix=/usr \
    --alsa \
    --classic \
    --dbus \
    --firewire \
    --doxygen \
    --portaudio

  python2 ./waf build


}

do_package() {

  python2 waf install --destdir=${pkg_prefix}

  # configure realtime access/scheduling
  install -Dm644 ${CACHE_PATH}/99-audio.conf ${pkg_prefix}/etc/security/limits.d/99-audio.conf
  install -Dm644 ${CACHE_PATH}/40-hpet-permissions.rules ${pkg_prefix}/usr/lib/udev/rules.d/40-hpet-permissions.rules
}

