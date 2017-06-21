pkg_origin=cosmos

pkg_name=farstream
pkg_version=0.2.8
pkg_description="Farstream - Audio/Video Communications Framework"
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/Farstream"
pkg_license=('LGPL')
pkg_deps=('libnice' 'gst-plugins-base' 'gst-plugins-good')
pkg_build_deps=('gobject-introspection' 'python2')
pkg_source=("http://freedesktop.org/software/farstream/releases/farstream/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('a40d4c4bd0812c270069b9f97d74009b')

do_build() {
  
  ./configure --prefix=/usr \
    --with-package-name='KaOS Farstream package' \
    --with-package-origin='http://kaosx.us' \
    --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
