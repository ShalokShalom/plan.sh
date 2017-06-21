pkg_origin=cosmos

pkg_name=libsndfile
pkg_version=1.0.28
pkg_description="A C library for reading and writing files containing sampled sound"
pkg_upstream_url="http://www.mega-nerd.com/libsndfile"
pkg_license=('LGPL')
pkg_deps=('alsa-lib' 'flac' 'libvorbis')
pkg_source=("http://www.mega-nerd.com/libsndfile/files/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('646b5f98ce89ac60cdb060fcd398247c')

do_build() {
  
  ./configure --prefix=/usr --disable-sqlite
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
