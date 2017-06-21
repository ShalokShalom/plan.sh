pkg_origin=cosmos

pkg_name=hicolor-icon-theme
pkg_version=0.15
pkg_description="Freedesktop.org Hicolor icon theme"
pkg_upstream_url="https://cgit.freedesktop.org/xdg/default-icon-theme/"
pkg_license=('GPL2')
pkg_source=("https://icon-theme.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('6aa2b3993a883d85017c7cc0cfc0fb73')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
