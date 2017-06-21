pkg_origin=cosmos

pkg_name=pulseaudio
pkg_description="A featureful, general-purpose sound server"
pkg_version=10.0
pkg_upstream_url="http://pulseaudio.org/"
pkg_license=('GPL' 'LGPL')
pkg_deps=('dbus' 'xcb-util' 'libasyncns' 'libcap' 'libxtst' 'libsm'
         'libsndfile' 'rtkit' 'libltdl' 'speex' 'tdb'
         'fftw' 'orc' 'webrtc-audio-processing' 'systemd' 'sbc' 'libsoxr')
pkg_build_deps=('attr' 'libltdl' 'avahi' 'bluez' 'intltool' 'jack' 'openssl'
             'pkgconfig' 'sh')
optpkg_deps=('avahi: zeroconf support'
            'bluez: bluetooth support'
            'jack: jack support'
            'openssl: RAOP support')
backup=(etc/pulse/{daemon.conf,default.pa,system.pa})
pkg_source=("https://freedesktop.org/software/pulseaudio/releases/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("$pkg_name-$pkg_version::git://anongit.freedesktop.org/pulseaudio/pulseaudio#commit=50186d7")
pkg_shasum=('4950d2799bf55ab91f6b7f990b7f0971')

do_build() {

  ./configure --prefix=/usr \
               --sysconfdir=/etc \
               --libexecdir=/usr/lib \
               --localstatedir=/var \
               --with-udev-rules-dir=/usr/lib/udev/rules.d \
               --with-database=tdb \
               --disable-rpath \
               --disable-bluez4 \
               --disable-default-build-tests

  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  # Disable cork-request module
  sed -e 's|/usr/bin/pactl load-module module-x11-cork-request|#&|' \
    -i ${CACHE_PATH}/usr/bin/start-pulseaudio-x11

  rm ${CACHE_PATH}/etc/dbus-1/system.d/pulseaudio-system.conf
  #rm ${CACHE_PATH}/etc/xdg/autostart/pulseaudio.desktop
  
  # fix no sound after logout https://github.com/KaOSx/apps/issues/112
  sed -e 's|load-module module-esound-protocol-unix|##load-module module-esound-protocol-unix|' \
    -i ${CACHE_PATH}/etc/pulse/default.pa
}
