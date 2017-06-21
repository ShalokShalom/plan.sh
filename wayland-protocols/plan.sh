pkg_origin=

pkg_name=wayland-protocols
pkg_version=1.8
pkg_description='Contains protocols and protocol extensions complementing the Wayland core protocol with additional functionality.'
pkg_upstream_url='https://wayland.freedesktop.org'
pkg_license=('MIT')
pkg_deps=('wayland')
pkg_source=("https://wayland.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('769f93b312b1323a8012565c3973cf7d')

do_build() {
   cd ${pkg_name}-${pkg_version}

   ./configure \
       --prefix=/usr 
   make
}

do_package() {
   cd ${pkg_name}-${pkg_version}
   make DESTDIR=${pkg_prefix} install

   install -Dm644 COPYING $pkg_prefix/usr/share/licenses/${pkg_name}/COPYING
}
