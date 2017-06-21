pkg_origin=cosmos

pkg_name=libevdev
pkg_version=1.5.7
pkg_description="Library for handling evdev kernel devices"
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/libevdev/"
pkg_license=('custom:X11')
pkg_deps=('glibc')
pkg_build_deps=('python2' 'doxygen' 'linux-headers') 
pkg_source=("https://freedesktop.org/software/libevdev/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=('4f1cfaee8d75ea3fbbfeb99a98730952')

do_build() {

   ./configure --prefix=/usr --disable-static
   make
}

do_package() {
   make DESTDIR=$pkg_prefix install

   install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
