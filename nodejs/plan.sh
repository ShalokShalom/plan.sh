pkg_origin=

pkg_name=nodejs
pkg_version=8.1.2
pkg_description="Platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications."
pkg_upstream_url='http://nodejs.org/'
pkg_license=('MIT')
pkg_deps=('python2' 'openssl' 'zlib' 'icu' 'libuv' 'c-ares')
pkg_build_deps=('procps-ng')
checkpkg_deps=('curl') 
pkg_source=("https://github.com/nodejs/node/archive/v${pkg_version}.tar.gz")
pkg_shasum=('0b69c1a3cce986cfaed4f87cfe8e710d')

do_build() {
  cd node-${pkg_version}
  
  ./configure --prefix=/usr \
    --with-intl=system-icu \
    --shared-openssl \
    --shared-cares \
    --shared-zlib 
  make
}

do_check() {
  cd node-${pkg_version}
  # 1 test fails bc of system-icu use
  make -j1 test
}

do_package() {
  cd node-${pkg_version}
  make install DESTDIR=${pkg_prefix}


  install -d ${pkg_prefix}/usr/share/doc/nodejs
  cp -r doc/api/* ${pkg_prefix}/usr/share/doc/nodejs
  install -D -m644 LICENSE ${pkg_prefix}/usr/share/licenses/nodejs/LICENSE
}

