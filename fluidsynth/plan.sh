pkg_origin=cosmos

pkg_name=fluidsynth
pkg_version=1.1.6
pkg_description="A real-time software synthesizer based on the SoundFont 2 specifications"
pkg_upstream_url="http://www.fluidsynth.org/"
pkg_deps=('glib2' 'jack' 'dbus' 'pulseaudio')
pkg_build_deps=('cmake' 'ladspa' 'doxygen')
pkg_license=('LGPL')
backup=('etc/conf.d/fluidsynth')
pkg_source=("https://sourceforge.net/projects/fluidsynth/files/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
        'fluidsynth.service')
pkg_shasum=('ae5aca6de824b4173667cbd3a310b263'
         'e0406748a154409907df62292be32e8a')

do_build() {

  cmake . -DCMAKE_INSTALL_PREFIX=/usr \
          -DCMAKE_BUILD_TYPE=Release \
          -Denable-ladspa=ON \
          -DLIB_SUFFIX=""
  make
}

do_package() {
  make DESTDIR=${pkg_prefix}/ install

  install -Dm644 ../fluidsynth.service ${pkg_prefix}/usr/lib/systemd/system/fluidsynth.service
}
