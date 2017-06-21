pkg_origin=cosmos

pkg_name=libinput
pkg_version=1.7.3
pkg_description="Library to handle input devices in Wayland compositors and to provide a generic X.Org input driver"
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/libinput/"
pkg_license=('custom:X11')
pkg_deps=('mtdev' 'systemd' 'libevdev' 'libwacom')
pkg_source=("https://freedesktop.org/software/libinput/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('f2993b477db8d7ec0e785ce04ffecb03')

do_build() {

  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
