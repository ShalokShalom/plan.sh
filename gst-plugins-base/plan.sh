pkg_origin=cosmos

pkg_name=gst-plugins-base
pkg_version=1.12.0
pkg_description="GStreamer Multimedia Framework Base Plugins"
pkg_upstream_url="https://gstreamer.freedesktop.org/"
pkg_license=('LGPL')
pkg_deps=("gstreamer>=${pkg_version}" 'orc' 'libxv' 'alsa-lib' 'cdparanoia' 'libvisual'
         'libvorbis' 'libtheora' 'pango' 'opus' 'iso-codes')
pkg_build_deps=('pkgconfig' 'gobject-introspection')
pkg_source=("https://gstreamer.freedesktop.org/src/gst-plugins-base/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('f34fc5630f9db0db53172fcf3b955e01')

do_build() {
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static \
    --enable-experimental \
    --with-package-name="GStreamer Base (KaOS)" \
    --with-package-origin="http://kaosx.us/" 
  make
  sed -e 's/^SUBDIRS_EXT =.*/SUBDIRS_EXT =/' -i Makefile
}

check() {
 
  make check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  make -C ext DESTDIR=${pkg_prefix} install
}

