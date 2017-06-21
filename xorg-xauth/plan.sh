pkg_origin=cosmos

pkg_name=xorg-xauth
pkg_version=1.0.10
pkg_description="X.Org authorization settings program"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libxmu')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/app/xauth-${pkg_version}.tar.bz2")
pkg_shasum=('f3f76cb10f69b571c43893ea6a634aa4')

do_build() {
  
  ./configure --prefix=/usr
  make 
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -d -m755 ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
