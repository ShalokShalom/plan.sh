pkg_origin=cosmos

pkg_name=xdelta3
pkg_version=3.1.0
pkg_description="A diff utility which works with binary files"
pkg_upstream_url="http://xdelta.org/"
pkg_license=('GPL')
pkg_deps=('xz')
pkg_source=("https://github.com/jmacd/xdelta-devel/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('5ac7b9d0dc9695124816ecbd397f5bee')

do_build() {
  
    ./configure --prefix=/usr
  make
}

do_check() {
  
  ./xdelta3 test
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
