pkg_origin=cosmos

pkg_name=librsvg
pkg_version=2.41.0
_pkg_version=2.41
pkg_description="SAX-based renderer for SVG files into a GdkPixbuf"
pkg_upstream_url="https://live.gnome.org/LibRsvg"
pkg_license=('LGPL')
pkg_deps=('gdk-pixbuf2' 'pango' 'libcroco')
pkg_build_deps=('intltool' 'gobject-introspection' 'cargo')
pkg_deps=('python: rsvg commandline utility')
pkg_source=("http://ftp.gnome.org/pub/gnome/sources/librsvg/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('b5f450facb5144f737a612fef01f57ed')

do_build() {
  # issue with current cargo https://github.com/rust-lang/cargo/issues/3340#issuecomment-263699137
  export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
  
  ./configure --prefix=/usr \
    --libexecdir=/usr/lib/${pkg_name} \
    --disable-static 
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
