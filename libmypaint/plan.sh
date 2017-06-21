pkg_origin=cosmos

pkg_name=libmypaint
pkg_version=1.2.80
_pkg_version=1.3.0-beta.1
pkg_description="Brushlib, is a library for making brushstrokes which is used by GIMP"
pkg_upstream_url="https://github.com/mypaint/libmypaint"
pkg_license=('ISC')
pkg_deps=('gegl' 'gobject-introspection' 'json-c')
pkg_build_deps=('intltool' 'python3')
pkg_source=("https://github.com/mypaint/libmypaint/releases/download/v${_pkg_version}/${pkg_name}-${_pkg_version}.tar.xz")
pkg_shasum=('ae92c6e5cb1002c76f9c81aa468cb04d')

do_build() {

  ./configure --prefix=/usr --enable-gegl
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
