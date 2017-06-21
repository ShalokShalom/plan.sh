pkg_origin=cosmos

pkg_name=jack
pkg_version=0.125.0
pkg_description="A low-latency audio server"
pkg_upstream_url="http://jackit.sourceforge.net/"
pkg_license=('GPL2' 'custom:LGPL2')
pkg_deps=('readline' 'libsamplerate' 'celt' 'libffado')
pkg_build_deps=('doxygen')
backup=(etc/conf.d/jack-audio-connection-kit)
install=${pkg_name}.install
pkg_source=("http://jackaudio.org/downloads/jack-audio-connection-kit-${pkg_version}.tar.gz"
        "99-audio.conf"
        "40-hpet-permissions.rules")
pkg_shasum=('d9b7e230aeae2d5b45c7a822b2d2dd15'
         '4d928a76e3f3d77d037c42ab75ac0f0b'
         '23eba69d2dbbb800f68176e5d38b9af5')

do_build() {

  ./configure --prefix=/usr \
              --libdir=/usr/lib
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 ${CACHE_PATH}/99-audio.conf $pkg_prefix/etc/security/limits.d/99-audio.conf
  install -Dm644 ${CACHE_PATH}/40-hpet-permissions.rules ${pkg_prefix}/lib/udev/rules.d/40-hpet-permissions.rules
  install -Dm644 ${CACHE_PATH}/jack-audio-connection-kit-$pkg_version/jack/jslist.h ${pkg_prefix}/usr/include/jack/jslist.h
}

