pkg_origin=cosmos

pkg_name=libxfont
pkg_version=1.5.2
pkg_description="X11 font rasterisation library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('freetype2' 'libfontenc' 'xproto' 'fontsproto')
pkg_build_deps=('xorg-util-macros' 'xtrans' 'git')
pkg_source=("http://xorg.freedesktop.org/archive/individual/lib/libXfont-${pkg_version}.tar.bz2")
# git build for http://lists.freedesktop.org/archives/xorg/2014-May/056616.html
#pkg_source=("git://anongit.freedesktop.org/xorg/lib/libXfont")
pkg_shasum=('254ee42bd178d18ebc7a73aacfde7f79')

do_build() {

  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
