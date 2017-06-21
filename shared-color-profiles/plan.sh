pkg_origin=cosmos

pkg_name=shared-color-profiles
pkg_version=0.1.5
pkg_description="Shared color profiles are used in color management aware applications"
pkg_upstream_url="http://github.com/hughsie/shared-color-profiles"
pkg_license=('GPL2')
pkg_source=("http://people.freedesktop.org/~hughsient/releases/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('65501b1376825b350b3deca97bbbf652')


do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR="$CACHE_PATH" install
}

