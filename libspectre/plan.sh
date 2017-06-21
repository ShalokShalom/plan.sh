pkg_origin=cosmos

pkg_name=libspectre
pkg_version=0.2.8
pkg_description="Small library for rendering Postscript documents"
pkg_license=('GPL2')
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/libspectre"
pkg_deps=('ghostscript')
pkg_source=("http://libspectre.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('97ad2c8188db6bdc77fd742522b0bbdf')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
