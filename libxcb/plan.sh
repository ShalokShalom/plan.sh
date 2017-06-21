pkg_name=libxcb
pkg_origin=cosmos
pkg_version=1.12
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X11 C Bindings"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://xcb.freedesktop.org/dist/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=092f147149d8a6410647a848378aaae749304d5b73e028ccb8306aa8a9e26f06
pkg_deps=(core/glibc xorg/libXau xorg/libXdmcp xorg/inputproto)
pkg_build_deps=(core/gcc core/make core/pkg-config core/diffutils core/python2 core/libxslt xorg/xproto xorg/xcb-proto xorg/libpthread-stubs)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

build() {
  cd ${pkg_name}-${pkg_name}
  
  autoreconf -vfi
  
  ./configure --prefix=/usr \
              --enable-xinput \
              --enable-xkb \
              --disable-static
  make
}

package () {
  cd ${pkg_name}-${pkg_name}
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}


