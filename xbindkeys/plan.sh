pkg_origin=cosmos

pkg_name=xbindkeys
pkg_version=1.8.6
pkg_description="Launch shell commands with keyboard or mouse under X"
pkg_upstream_url="http://www.nongnu.org/xbindkeys/xbindkeys.html"
pkg_license=('GPL')
pkg_deps=('libx11' 'guile' 'tk')
pkg_source=("http://www.nongnu.org/xbindkeys/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c6ea9db56e075dae0697497e2ed390cc')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
