pkg_origin=cosmos
 
pkg_name=libxfont2
pkg_version=2.0.1
pkg_description="X11 font rasterisation library, version 2"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('freetype2' 'libfontenc' 'xproto' 'fontsproto')
pkg_build_deps=('xorg-util-macros' 'xtrans')
pkg_source=("http://xorg.freedesktop.org/archive/individual/lib/libXfont2-${pkg_version}.tar.bz2")
# git build for http://lists.freedesktop.org/archives/xorg/2014-May/056616.html
#pkg_source=("git://anongit.freedesktop.org/xorg/lib/libXfont")
pkg_shasum=('0d9f6dd9c23bf4bcbfb00504b566baf5')

do_build() {

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --disable-static
    
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
