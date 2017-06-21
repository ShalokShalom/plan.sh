pkg_origin=cosmos

pkg_name=libgsf
pkg_version=1.14.41
pkg_description="The GNOME Structured File Library is a utility library for reading and writing structured file formats"
pkg_upstream_url="http://www.gnome.org/"
pkg_license=('GPL' 'LGPL')
pkg_deps=('libxml2' 'glib2' 'bzip2')
pkg_build_deps=('intltool' 'pkgconfig' 'python2' 'gobject-introspection')
pkg_source=("http://ftp.gnome.org/pub/GNOME/sources/libgsf/1.14/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('5b039d1b7196e643315abda1c1c349c4')

do_build() {
  PYTHON=/usr/bin/python2
  
  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --localstatedir=/var \
              --mandir=/usr/share/man \
              --disable-static \
              --enable-introspection
  make 
}

do_package() {
  make DESTDIR=${pkg_prefix} install 
  
  #All removes will strip gnome specific stuff
  rm -f ${pkg_prefix}/usr/share/man/man1/gsf-office-thumbnailer.1
  rm -f ${pkg_prefix}/usr/lib/libgsf-gnome*
  rm -rf ${pkg_prefix}/usr/include/libgsf-1/gsf-gnome/
  rm -rf ${pkg_prefix}/etc/gconf
  rm -f ${pkg_prefix}/usr/lib/pkgconfig/libgsf-gnome-1.pc
  rm -f ${pkg_prefix}/usr/bin/gsf-office-thumbnailer
  rm -f ${pkg_prefix}/usr/lib/python*/site-packages/gsf/gnomemodule.so
}
