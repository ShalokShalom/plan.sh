pkg_origin=cosmos

pkg_name=alsa-utils
pkg_version=1.1.4
pkg_description="An alternative implementation of Linux sound support"
pkg_upstream_url="https://www.alsa-project.org"
pkg_deps=('alsa-lib' 'dialog' 'pciutils' 'ncurses' 'psmisc' 'libsamplerate' 'fftw')
pkg_build_deps=('xmlto' 'docbook-xsl')
pkg_license=('GPL')
pkg_source=("ftp://ftp.alsa-project.org/pub/utils/$pkg_name-${pkg_version}.tar.bz2"
        '90alsa')
pkg_shasum=('01e3934ca5bd22a80c27289d1b0adcdc'
         '529216f6a46e61a546640e08ea7a0879')

do_build() {

  ./configure --prefix=/usr \
    --disable-alsaconf \
    --with-udev-rules-dir=/usr/lib/udev/rules.d \
    --with-systemdsystemunitdir=/usr/lib/systemd/system
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -D -m755 ../90alsa ${pkg_prefix}/etc/pm/sleep.d/90alsa
  # dir where to save ALSA state
  install -d ${pkg_prefix}/var/lib/alsa
}

