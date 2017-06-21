pkg_origin=cosmos

pkg_name=fltk
pkg_version=1.3.4
pkg_description="Graphical user interface toolkit for X."
pkg_license=('custom:LGPL')
pkg_upstream_url="http://www.fltk.org/"
pkg_deps=('libjpeg-turbo' 'libpng' 'libxft' 'libxinerama' 'hicolor-icon-theme'
         'desktop-file-utils' 'xdg-utils' 'libgl' 'libxcursor' 'glu')
pkg_build_deps=('mesa' 'doxygen' 'alsa-lib')
groups=('system')
pkg_source=("http://fltk.org/pub/fltk/${pkg_version}/${pkg_name}-${pkg_version}-source.tar.gz"
        'x-fluid.desktop')
pkg_shasum=('c0e43ac259ac8c5d0f7634566e21e3f8'
         '44cbb9e387f58c7de1bc9ed42d9a128f')

do_build() {
  
  cp ${CACHE_PATH}/x-fluid.desktop fluid/

  sed -i -e 's/$(LINKFLTK)/$(LINKSHARED)/' \
         -e 's/$(LINKFLTKIMG)/$(LINKSHARED)/' test/Makefile
  sed -i 's/class Fl_XFont_On_Demand/class FL_EXPORT Fl_XFont_On_Demand/' FL/x.H

  ./configure --prefix=/usr \
              --enable-shared \
              --enable-threads \
              --enable-xft \
              --enable-gl

  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  ( cd fluid && make DESTDIR=${pkg_prefix} install install-linux )

  chmod 644 ${pkg_prefix}/usr/lib/*.a
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

