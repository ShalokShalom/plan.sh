pkg_origin=cosmos

pkgbase=glib2
pkg_name=('glib2' 'glib2-docs')
pkg_version=2.52.2
_pkg_version=2.52
pkg_description="Common C routines used by GTK+ and other libs"
pkg_upstream_url="https://www.gtk.org/overview.php"
pkg_build_deps=('pkg-config' 'python3' 'libxslt' 'docbook-xml' 'pcre' 'libffi' 'elfutils')
pkg_source=("https://ftp.gnome.org/pub/GNOME/sources/glib/${_pkg_version}/glib-${pkg_version}.tar.xz"
        'revert-warn-glib-compile-schemas.patch'
        'gio-querymodules.hook'
        'glib-compile-schemes.hook')
pkg_shasum=('ec099bce26ce6a85104ed1d89bb45856'
         '3265d1afbcf1f5f308e26c3f9f6ca899'
         'a52ea506b5cf162a4f72d09cc33fae50'
         '9e25d7de10bc4dc105f171e9ae46ef69')

do_prepare() {
  cd glib-${pkg_version}
  
  patch -Rp1 -i ../revert-warn-glib-compile-schemas.patch
}
  
do_build() {
  cd glib-${pkg_version}
  
  PYTHON=/usr/bin/python3 ./configure --prefix=/usr --libdir=/usr/lib \
      --sysconfdir=/etc \
      --with-pcre=system \
      --disable-fam
  make
}

package_glib2() {
  pkg_deps=('pcre' 'libffi')
  options=('!docs' '!libtool' '!emptydirs')
  pkg_license=('LGPL')

  cd glib-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -dm755 ${pkg_prefix}/usr/share/libalpm/hooks/
  install -m644 ../glib-compile-schemes.hook ${pkg_prefix}/usr/share/libalpm/hooks/
  install -m644 ../gio-querymodules.hook ${pkg_prefix}/usr/share/libalpm/hooks/
}

package_glib2-docs() {
  pkg_description="Documentation for glib2"
  pkg_license=('custom')
  options=('docs' '!emptydirs')
  
  cd glib-${pkg_version}/docs
  make DESTDIR=${pkg_prefix} install
  install -m755 -d ${pkg_prefix}/usr/share/licenses/glib2-docs
  install -m644 reference/COPYING ${pkg_prefix}/usr/share/licenses/glib2-docs/

  rm -rf ${pkg_prefix}/usr/share/man
}
