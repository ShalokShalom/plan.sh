pkg_origin=cosmos

pkg_name=gst-plugins-bad
pkg_version=1.12.0
pkg_description="GStreamer Multimedia Framework Bad Plugins"
pkg_license=('LGPL')
pkg_upstream_url="https://gstreamer.freedesktop.org/"
pkg_deps=('mjpegtools' 'gst-plugins-base' 'curl' 'chromaprint' 'libmms' 'faad2'
         'mpg123' 'faac' 'celt' 'libdca' 'soundtouch' 'libdvdnav'
         'libmodplug' 'libgme' 'opus' 'wayland' 'neon' 'libofa' 'fluidsynth' 'openjpeg'
         'libwebp' 'libsrtp' 'gnutls' 'librsvg' 'libpng' 'libgudev' 'sbc' 'glu'
         'qt5-x11extras' 'x265' 'libass')
pkg_build_deps=('schroedinger' 'libexif' 'libdvdread' 'libvdpau' 'libmpeg2' 'python3' 
             'gobject-introspection' 'bluez' 'ladspa' 'openal' 'qt5-wayland')
pkg_source=("https://gstreamer.freedesktop.org/src/gst-plugins-bad/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('a1813105dc7394aff0be6dbedbf7c6d5')

do_build() {
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static \
    --enable-experimental \
    --with-package-name="GStreamer (KaOS)" \
    --with-package-origin="http://kaosx.us"
    
  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool 
  
  make
}

check() {
  
  make -k check || :
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
