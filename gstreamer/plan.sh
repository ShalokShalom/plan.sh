pkg_origin=cosmos

pkg_name=gstreamer
pkg_version=1.12.0
pkg_description="GStreamer Multimedia Framework"
pkg_license=('LGPL')
pkg_upstream_url="https://gstreamer.freedesktop.org/"
pkg_deps=('libxml2' 'glib2')
pkg_deps=('sh: feedback script')
pkg_build_deps=('intltool' 'pkgconfig' 'gobject-introspection')
pkg_source=("https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${pkg_version}.tar.xz")
pkg_shasum=('8f76b6b5e4b3307e505bd6ab9304dd03')

do_build() {
  
    ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --libexecdir=/usr/lib \
      --with-package-name="GStreamer (KaOS)" \
      --with-package-origin="http://kaosx.us/" \
      --disable-static
  make
}

check() {
  
  make check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
