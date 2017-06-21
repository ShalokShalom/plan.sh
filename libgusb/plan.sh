pkg_origin=cosmos

pkg_name=libgusb
pkg_version=0.2.10
pkg_description="GLib wrapper around libusb1"
pkg_upstream_url="https://github.com/hughsie/libgusb"
pkg_license=('LGPL2.1')
pkg_deps=('systemd' 'libusb')
pkg_build_deps=('gobject-introspection')
pkg_source=("https://people.freedesktop.org/~hughsient/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('5f2658e02fee6d7b484a40c4afc48c5c')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

