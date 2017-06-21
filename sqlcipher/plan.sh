pkg_origin=

pkg_name=sqlcipher
pkg_version=3.4.1
pkg_description="SQLite extension that provides transparent 256-bit AES encryption of database files"
pkg_upstream_url="https://www.zetetic.net/sqlcipher/"
pkg_license=('BSD')
pkg_deps=('openssl' 'sqlite')
pkg_build_deps=('tcl')
pkg_source=("https://github.com/sqlcipher/${pkg_name}/archive/v${pkg_version}.tar.gz")
pkg_shasum=('edd1c57129c21a22ab2c2fd7f47d4ccd')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
    ./configure --prefix=/usr --enable-tempstore=yes CFLAGS="$CFLAGS -DSQLITE_HAS_CODEC " \
    LDFLAGS="-lcrypto" 
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -D -m 0644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
} 
