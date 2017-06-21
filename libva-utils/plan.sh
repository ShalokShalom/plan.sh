pkg_origin=cosmos

pkg_name=libva-utils
pkg_version=1.8.2
pkg_description="Libva with patches to extend VA API with data needed for VDPAU and XvBA backends."
pkg_upstream_url="https://github.com/01org/libva-utils"
pkg_license=('MIT')
pkg_deps=('libva')
pkg_source=("https://www.freedesktop.org/software/vaapi/releases/libva/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('4a8edb92fb0b439f1146adbfa0fba76d')

do_build() {
  
  ./configure --prefix=/usr  
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m644 -D COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}

