pkg_origin=cosmos

pkg_name=desktop-file-utils
pkg_version=0.23
pkg_description="Command line utilities for working with desktop entries"
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/desktop-file-utils"
pkg_license=('GPL')
pkg_deps=('glib2')
pkg_source=("http://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-${pkg_version}.tar.xz"
        'update-desktop-database.hook')
pkg_shasum=('599133d51cc9a41bfec186414906b6f1'
         '63b2a090a303cbf9e244dc79b40fd81b')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ../update-desktop-database.hook ${pkg_prefix}/usr/share/libalpm/hooks/update-desktop-database.hook
}
