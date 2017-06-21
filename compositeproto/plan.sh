pkg_origin=cosmos

pkg_name=compositeproto
pkg_version=0.4.2
pkg_description="X11 Composite extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('fixesproto')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('98482f65ba1e74a08bf5b056a4031ef0')

do_build() {
  ./configure --prefix=/usr
  make
}

do_package(){
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

