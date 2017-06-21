pkg_origin=cosmos

pkg_name=gstreamer-libde265
pkg_version=0.1.12
pkg_description="HEVC/H.265 video decoder using libde265 (GStreamer plugin)."
pkg_upstream_url="https://github.com/strukturag/gstreamer-libde265"
pkg_license=('LGPL3')
pkg_deps=('gstreamer' 'gst-plugins-bad' 'gst-plugins-base' 'gst-plugins-good' 'libde265' 'zlib')
pkg_source=("https://github.com/strukturag/gstreamer-libde265/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('f5a37775c73583919cc53f07d9ec338a')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  
  make PREFIX=/usr DESTDIR=${pkg_prefix} install
}
