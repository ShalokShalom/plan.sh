pkg_origin=cosmos

pkg_name=gegl
pkg_version=0.3.18
_pkg_version=0.3
pkg_description="Graph based image processing framework."
pkg_upstream_url="http://www.gegl.org/"
pkg_license=('GPL3' 'LGPL3')
pkg_deps=('babl' 'ffmpeg' 'openexr' 'librsvg' 'jasper' 'json-glib' 'libwebp' 'libraw' 'gexiv2')
pkg_build_deps=('ruby' 'lua' 'exiv2' 'intltool' 'gobject-introspection')
pkg_source=("https://download.gimp.org/pub/gegl/${_pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('6e5c6f229261478dc436a38c84405b2a')

do_build() {

  ./configure --prefix=/usr \
    --with-sdl \
    --with-openexr \
    --with-librsvg \
    --with-libavformat \
    --with-jasper \
    --disable-docs 
  make
}

do_package() {
  
  make install DESTDIR=${pkg_prefix}
}

