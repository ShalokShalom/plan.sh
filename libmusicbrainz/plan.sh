pkg_origin=cosmos

pkg_name=libmusicbrainz
pkg_version=5.1.0
pkg_description="Library That Provides Access to the MusicBrainz Server  "
pkg_upstream_url="http://musicbrainz.org/doc/libmusicbrainz"
pkg_license=('LGPL2.1')
pkg_deps=('neon' 'libdiscid')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/downloads/metabrainz/libmusicbrainz/libmusicbrainz-3.0.3.tar.gz"
        "https://github.com/downloads/metabrainz/libmusicbrainz/libmusicbrainz-4.0.3.tar.gz"
        "https://github.com/metabrainz/libmusicbrainz/releases/download/release-${pkg_version}/libmusicbrainz-${pkg_version}.tar.gz")
pkg_shasum=('f4824d0a75bdeeef1e45cc88de7bb58a'
         '19b43a543d338751e9dc524f6236892b'
         '4cc5556aa40ff7ab8f8cb83965535bc3')

do_build() {

  msg "Building LibMusicBrainz 3"
  cmake . \
      -DCMAKE_INSTALL_PREFIX:PATH=/usr \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DBUILD_STATIC_LIBS:BOOL=OFF
  make
  
  msg "Building LibMusicBrainz 4"
  cmake . \
      -DCMAKE_INSTALL_PREFIX:PATH=/usr
  make

  msg "Building LibMusicBrainz 5"
  cmake . \
      -DCMAKE_INSTALL_PREFIX:PATH=/usr \
      -DBUILD_SHARED_LIBS:BOOL=ON
  make


}

do_package() {
  make DESTDIR=${pkg_prefix} install

  make DESTDIR=${pkg_prefix} install

  make DESTDIR=${pkg_prefix} install
}
