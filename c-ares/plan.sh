pkg_origin=cosmos

pkg_name=c-ares
pkg_version=1.12.0
pkg_description='C library that performs DNS requests and name resolves asynchronously'
pkg_upstream_url='http://c-ares.haxx.se/'
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=("http://c-ares.haxx.se/download/${pkg_name}-${pkg_version}.tar.gz"
        'LICENSE')
pkg_shasum=('2ca44be1715cd2c5666a165d35788424'
         'c69f2042941b708ce3e7121424d0b7e6')

do_build() {

  ./configure --prefix=/usr --enable-shared
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE
}
