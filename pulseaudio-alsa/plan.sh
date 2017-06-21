pkg_origin=cosmos

pkg_name=pulseaudio-alsa
pkg_version=2
pkg_description="ALSA Configuration for PulseAudio"
pkg_upstream_url="http://www.pulseaudio.org"
pkg_license=('GPL')
pkg_deps=('alsa-plugins' 'pulseaudio')
backup=('etc/asound.conf')
pkg_source=('asound.conf')
pkg_shasum=('0461fda1c6f6e256c28c24cb5d58af33')

do_package() {
  install -Dm644 ${CACHE_PATH}/asound.conf ${CACHE_PATH}/etc/asound.conf
}
