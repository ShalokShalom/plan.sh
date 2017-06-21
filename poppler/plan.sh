pkg_origin=cosmos

pkgbase=poppler
pkg_name=('poppler' 'poppler-glib' 'poppler-qt5')
pkg_version=0.55.0
pkg_upstream_url="https://poppler.freedesktop.org/"
pkg_license=('GPL')
pkg_build_deps=('libjpeg-turbo' 'gcc-libs' 'cairo' 'libxml2' 'openjpeg' 'qt5-base'
             'pkgconfig' 'lcms2' 'fontconfig' 'icu' 'gobject-introspection' 'nss')
pkg_source=("https://poppler.freedesktop.org/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('f7a8230626b6d2061acfdc852930b7dd')


do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc \
      --localstatedir=/var --disable-static \
      --enable-cairo-output \
      --enable-xpdf-headers \
      --enable-libjpeg --enable-zlib \
      --disable-poppler-qt4 \
      --enable-poppler-qt5 \
      --enable-poppler-glib 
      
  make
}

package_poppler() {
  pkg_description="PDF rendering library based on xpdf 3.0"
  pkg_deps=('libjpeg' 'gcc-libs' 'cairo' 'libxml2' 'fontconfig' 'openjpeg' 'lcms2' 'poppler-data')

  sed -e 's/^glib_subdir =.*/glib_subdir =/' \
      -e 's/^qt4_subdir =.*/qt4_subdir =/' \
      -e 's/^qt5_subdir =.*/qt5_subdir =/' -i Makefile
  make DESTDIR=${pkg_prefix} install

  rm -f ${pkg_prefix}/usr/lib/pkgconfig/poppler-{glib,qt4,qt5}.pc
}

package_poppler-glib() {
  pkg_description="Poppler glib bindings"
  pkg_deps=("poppler=${pkg_version}" 'glib2')

  make DESTDIR=${pkg_prefix} install-libLTLIBRARIES
  
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/lib/pkgconfig
  install -m644 ../poppler-glib.pc ${pkg_prefix}/usr/lib/pkgconfig/
  rm -f ${pkg_prefix}/usr/lib/libpoppler.*
  rm -f ${pkg_prefix}/usr/bin/poppler-glib-demo
}

package_poppler-qt5() {
  pkg_description="Poppler Qt5 bindings"
  pkg_deps=("poppler=${pkg_version}" 'qt5-base')
  provides=('poppler-qt')
  replaces=('poppler-qt')
  conflicts=('poppler-qt')

  make DESTDIR=${pkg_prefix} install-libLTLIBRARIES
  
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/lib/pkgconfig
  install -m644 ../poppler-qt5.pc "${pkg_prefix}/usr/lib/pkgconfig/"
  rm -f ${pkg_prefix}/usr/lib/libpoppler.*
}


