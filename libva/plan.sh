pkg_origin=cosmos

pkg_name=libva
pkg_version=1.8.2
pkg_description="Libva with patches to extend VA API with data needed for VDPAU and XvBA backends."
pkg_upstream_url="https://github.com/01org/libva"
pkg_license=('MIT')
pkg_deps=('libgl' 'libdrm' 'libxfixes')
pkg_build_deps=('mesa')
pkg_source=("https://www.freedesktop.org/software/vaapi/releases/libva/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('2ce6901495b64f4cc26dd0fb53eb5b14')

do_build() {
  
  ./configure --prefix=/usr  
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m644 -D COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}

