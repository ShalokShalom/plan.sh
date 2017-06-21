pkg_origin=cosmos

pkg_name=audiofile
pkg_version=0.3.6
pkg_description="Silicon Graphics Audio File Library"
pkg_upstream_url="http://www.68k.org/~michael/audiofile/"
pkg_license=('LGPL')
pkg_deps=('gcc-libs' 'alsa-lib' 'flac')
pkg_source=("http://pkgs.fedoraproject.org/repo/pkgs/audiofile/audiofile-0.3.6.tar.gz/2731d79bec0acef3d30d2fc86b0b72fd/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2731d79bec0acef3d30d2fc86b0b72fd')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
