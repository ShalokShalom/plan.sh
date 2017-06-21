pkg_origin=cosmos

pkg_name=libshout
pkg_version=2.4.1
pkg_description="Library for accessing a shoutcast/icecast server"
pkg_deps=('libvorbis' 'libtheora' 'speex')
pkg_upstream_url="http://www.icecast.org/"
pkg_license=('LGPL')
pkg_source=("http://downloads.xiph.org/releases/libshout/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('89cebf8cb0197f639cde69c95177fe47')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
  make LDFLAGS+=-lspeex
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
