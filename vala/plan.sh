pkg_origin=cosmos

pkg_name=vala
pkg_version=0.36.3
_pkg_version=0.36
pkg_description="Compiler for the GObject type system."
pkg_upstream_url="http://live.gnome.org/Vala"
pkg_license=('LGPL')
pkg_deps=('glib2')
pkg_build_deps=('libxslt')
pkg_source=("https://download.gnome.org/sources/vala/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('ff093f46e1d2e0b179543ec43cf27d76')

do_build() {

  ./configure --prefix=/usr --enable-vapigen
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
