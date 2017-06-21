pkg_origin=cosmos

pkg_name=renderproto
pkg_version=0.11.1
pkg_description="X11 Render extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('a914ccc1de66ddeb4b611c6b0686e274')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -D -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
