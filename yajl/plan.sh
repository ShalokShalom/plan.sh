pkg_origin=cosmos

pkg_name=yajl
pkg_version=2.1.0
pkg_description='Yet Another JSON Library.'
pkg_upstream_url='http://lloyd.github.com/yajl/'
pkg_license=('ISC')
pkg_build_deps=('cmake')
pkg_source=("$pkg_name-$pkg_version.tar.gz::https://github.com/lloyd/yajl/tarball/$pkg_version")
pkg_shasum=('8df8a92a2799bc949577e8e7a9f43670')

do_build() {
  dirname=$(tar tf "$CACHE_PATH/$pkg_name-$pkg_version.tar.gz" | sed 1q);

  cmake -DCMAKE_INSTALL_PREFIX=/usr .

  make
}

do_package() {
  dirname=$(tar tf "$CACHE_PATH/$pkg_name-$pkg_version.tar.gz" | sed 1q);

  make DESTDIR="$CACHE_PATH" install

  install -Dm644 COPYING "$CACHE_PATH/usr/share/licenses/${pkg_name}/LICENSE"
}
