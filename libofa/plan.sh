pkg_origin=cosmos

pkg_name=libofa
pkg_version=0.9.3
pkg_description="Open Fingerprint Architecture"
pkg_upstream_url="http://code.google.com/p/musicip-libofa/"
pkg_license=('GPL2' 'custom')
pkg_deps=('expat' 'curl' 'fftw' 'gcc-libs')
pkg_build_deps=('pkgconfig')
pkg_source=("https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/musicip-libofa/$pkg_name-$pkg_version.tar.gz"
        'gcc-4.patch' 
        'libofa-0.9.3-gcc-4.3.patch'
        'gcc4.5.patch'
        'libofa-0.9.3-curl-7.21.patch'
        'gcc-47.patch')
pkg_shasum=('51507d2c4b432bd2755f48d58471696e'
         'a6f78b90bd0f4354d022a71c3e58ef6c'
         'dd57db13770b8f8d196e8a3d3a50e713'
         'c245363368d0e6fa2b4676364b81b74f'
         '2e1579d74613cfbb1799d0ab5f1a4cba'
         '69cb2996c984adc80e368109e17e48ea')

do_build() {

  patch -p0 -i ${CACHE_PATH}/gcc-4.patch
  patch -p1 -i ${CACHE_PATH}/libofa-0.9.3-gcc-4.3.patch
  patch -p1 -i ${CACHE_PATH}/gcc4.5.patch
  patch -p1 -i ${CACHE_PATH}/libofa-0.9.3-curl-7.21.patch
  patch -p1 -i ${CACHE_PATH}/gcc-47.patch
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
