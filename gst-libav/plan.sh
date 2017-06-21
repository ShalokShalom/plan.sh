pkg_origin=cosmos

pkg_name=gst-libav
pkg_version=1.12.0
pkg_description="Gstreamer libav Plugin"
pkg_license=('GPL')
pkg_upstream_url="https://gstreamer.freedesktop.org/"
pkg_deps=('gst-plugins-base' 'bzip2')
pkg_build_deps=('yasm' 'python3')
pkg_source=("https://gstreamer.freedesktop.org/src/gst-libav/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('f9c4593947f8484b237c5d9782939ec3')

do_build() {

  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --disable-static \
      --with-libav-extra-configure="--enable-runtime-cpudetect" \
      --with-package-name="GStreamer libav Plugin (KaOS)" \
      --with-package-origin="http://kaosx.us/"

  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool

  make
}

check() {

  make check
}

do_package() {

  make DESTDIR="${pkg_prefix}" install
}
