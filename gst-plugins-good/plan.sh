pkg_origin=cosmos

pkg_name=gst-plugins-good
pkg_version=1.12.0
pkg_description="GStreamer Multimedia Framework Good Plugins"
pkg_license=('LGPL')
pkg_upstream_url="https://gstreamer.freedesktop.org/"
pkg_deps=('pulseaudio' 'jack' 'libsoup' 'gst-plugins-base' 'wavpack' 'aalib' 'taglib' 'libdv' 'libshout'
         'libvpx' 'gdk-pixbuf2' 'libcaca' 'libavc1394' 'libiec61883' 'libxdamage' 'v4l-utils' 'libgudev')
pkg_build_deps=('gstreamer' 'speex' 'flac' 'libraw1394' 'python3')
pkg_source=("https://gstreamer.freedesktop.org/src/gst-plugins-good/${pkg_name}-${pkg_version}.tar.xz"
        'equalizer.patch')
pkg_shasum=('9294b22ddab3bec373cbc5e84ff4c084'
         '36a5b58e136f711152b17db3e30f225e')

do_build() {
  # https://github.com/clementine-player/Clementine/issues/4541
  # https://bugzilla.gnome.org/show_bug.cgi?id=737886
  #patch -p1 -i "${CACHE_PATH}/equalizer.patch"
 
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static \
    --enable-experimental \
    --with-package-name="GStreamer Good (KaOS)" \
    --with-package-origin="http://kaosx.us/"
  make
}

check() {

  make check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
