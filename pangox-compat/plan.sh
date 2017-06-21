pkg_origin=cosmos

pkg_name=pangox-compat
pkg_version=0.0.2
_pkg_version=0.0
pkg_description="X Window System font support for Pango"
pkg_license=('LGPL')
pkg_deps=('pango')
pkg_source=("http://ftp.gnome.org/pub/gnome/sources/${pkg_name}/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_upstream_url="http://www.pango.org/"
pkg_shasum=('7bcbd0187f03e1e27af9a81e07249c33')

do_build() {

  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --localstatedir=/var \
              --disable-static
  make
}

do_package() {
  
  make -j1 DESTDIR="${pkg_prefix}" install
}
