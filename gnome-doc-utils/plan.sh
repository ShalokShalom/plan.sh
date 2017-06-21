pkg_origin=cosmos

pkg_name=gnome-doc-utils
pkg_version=0.20.10
pkg_description="Documentation utilities for Gnome"
pkg_license=('GPL' 'LGPL')
pkg_deps=('libxslt' 'python2' 'docbook-xml' 'rarian')
pkg_build_deps=('pkg-config' 'intltool')
pkg_upstream_url="http://www.gnome.org"
pkg_source=("http://ftp.gnome.org/pub/gnome/sources/gnome-doc-utils/0.20/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('3c64ad7bacd617b04999e4a168afaac5')

do_build() {
  
  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --mandir=/usr/share/man \
      --localstatedir=/var \
      --disable-scrollkeeper 
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
