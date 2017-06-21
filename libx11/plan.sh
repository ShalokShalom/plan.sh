pkg_origin=cosmos
pkg_name=libx11
pkg_version=1.6.5
pkg_description="X11 client-side library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('cosmos/libxcb' 'xorg/xproto' 'xorg/kbproto')
pkg_build_deps=('cosmos/util-macros' 'cosmos/xextproto' 'xorg/xtrans' 'core/cmake' 'core/make' 'xorg/inputproto' 'core/coreutils' 'core/autoconf' 'core/autogen' 'core/automake')
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libX11-${pkg_version}.tar.bz2")
pkg_shasum=4d3890db2ba225ba8c55ca63c6409c1ebb078a2806de59fb16342768ae63435d

do_build() {
  attach ./configure --prefix=/usr --disable-static --disable-xf86bigfont
  make
}

do_check() {
  
  make check
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -d -m755 ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
