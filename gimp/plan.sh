pkg_origin=

pkg_name=gimp
pkg_version=2.9.4
_pkg_version=2.9
pkg_description="GNU Image Manipulation Program"
pkg_upstream_url="http://www.gimp.org/"
pkg_license=('GPL3' 'LGPL3')
pkg_deps=('pygtk' 'lcms' 'libxpm' 'librsvg' 'libmng' 'libgudev' 'dbus-glib' 
         'jasper' 'libexif' 'gegl' 'desktop-file-utils' 'hicolor-icon-theme' 'gexiv2' 'libmypaint')
pkg_build_deps=('intltool' 'poppler-glib' 'alsa-lib' 'iso-codes' 'curl' 'ghostscript')
optpkg_deps=('gutenprint: for sophisticated printing only as gimp has built-in cups print support'
            'poppler-glib: for pdf support'
            'alsa-lib: for MIDI event controller module'
            'curl: for URI support')
pkg_source=("http://download.gimp.org/pub/gimp/v${_pkg_version}/gimp-${pkg_version}.tar.bz2"
        'linux.gpl'
        "https://github.com/GNOME/gimp/commit/46bcd82800e37b0f5aead76184430ef2fe802748.diff")
pkg_shasum=('6b3d425a7949110eeb532badedf721f3'
         'bb27bc214261d36484093e857f015f38'
         'd70307cb284307d36a16bd0335a78259')

do_build() {
  cd gimp-${pkg_version}
  #sed -e "s|gegl-0.2 >= 0.2.0|gegl-0.3 >= 0.3.0|" -i ${CACHE_PATH}/gimp-${pkg_version}/configure
  # CVE-2007-3126
  patch -p1 -i ${CACHE_PATH}/46bcd82800e37b0f5aead76184430ef2fe802748.diff
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --enable-mp \
    --enable-gimp-console \
    --enable-python \
    --without-aa \
    --without-wmf 
    #--enable-vector-icons
  make
}

do_package() {
  cd gimp-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ${CACHE_PATH}/linux.gpl ${pkg_prefix}/usr/share/gimp/2.0/palettes/Linux.gpl

  ln -sf gimp-console-${pkg_version}.1.gz ${pkg_prefix}/usr/share/man/man1/gimp-console.1.gz
  ln -sf gimprc-${pkg_version}.5.gz ${pkg_prefix}/usr/share/man/man5/gimprc.5.gz
  ln -sf gimptool-2.0.1.gz ${pkg_prefix}/usr/share/man/man1/gimptool.1.gz
  ln -s gimp-${pkg_version}.1.gz ${pkg_prefix}/usr/share/man/man1/gimp.1.gz
}
