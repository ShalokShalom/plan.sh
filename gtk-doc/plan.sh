pkg_origin=cosmos

pkg_name=gtk-doc
pkg_version=1.25
pkg_description="Documentation tool for public library API"
pkg_license=('GPL' 'FDL')
pkg_deps=('docbook-xsl' 'perl')
pkg_build_deps=('pkgconfig' 'jade' 'itstool')
pkg_upstream_url="http://www.gtk.org/gtk-doc/"
pkg_source=("http://ftp.gnome.org/pub/gnome/sources/${pkg_name}/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('0dc6570953112a464a409fb99258ccbc')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

