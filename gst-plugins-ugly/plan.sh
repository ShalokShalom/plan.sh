pkg_origin=cosmos

pkg_name=gst-plugins-ugly
pkg_version=1.12.0
pkg_description="GStreamer Multimedia Framework Ugly Plugins"
pkg_license=('LGPL')
pkg_upstream_url="https://gstreamer.freedesktop.org/"
pkg_deps=('gst-plugins-base' 'libdvdread' 'lame' 'libmpeg2' 'a52dec'
         'libmad' 'libsidplay' 'libcdio' 'x264' 'opencore-amr')
pkg_build_deps=('python3')
pkg_source=("https://gstreamer.freedesktop.org/src/gst-plugins-ugly/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('30e815834819a4890eb1ef6ef67cf68d')

do_build() {

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static \
    --enable-experimental \
    --with-package-name="GStreamer (KaOS)" \
    --with-package-origin="http://kaosx.us"
  make
}

check() {
  
  make check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
