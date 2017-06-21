pkg_origin=cosmos

pkg_name=libdvdcss
pkg_version=1.4.0
pkg_description="Cross-platform library for transparent DVD device access with on-the-fly CSS decryption."
pkg_upstream_url="https://code.videolan.org/videolan/libdvdcss"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("https://download.videolan.org/pub/libdvdcss/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2"
        "https://code.videolan.org/videolan/libdvdcss/commit/6b95108d3de1755beab102b3a02ca7ef02494bd1.diff")
pkg_shasum=('2edba36e6af3f0223c4f0454cdf3d159'
         'b2b452265bc55e599e1a0c6c61eebbce')

prepare() {

  patch -R -p1 -i ${CACHE_PATH}/6b95108d3de1755beab102b3a02ca7ef02494bd1.diff
}

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
