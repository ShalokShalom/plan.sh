pkg_origin=cosmos

pkg_name=libdiscid
pkg_version=0.6.2
pkg_license=('LGPL')
pkg_description="A Library for creating MusicBrainz DiscIDs"
pkg_upstream_url="http://musicbrainz.org/doc/libdiscid"
pkg_deps=('glibc')
pkg_source=("http://ftp.musicbrainz.org/pub/musicbrainz/libdiscid/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2812bb678f5142efdfd0d0f7d6ea87d6')

do_build() {
  
  ./configure --prefix=/usr
  make
}

check() {
  
  make check
}


do_package() {
  
  make prefix=${pkg_prefix}/usr install
}
