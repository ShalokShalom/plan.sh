pkg_origin=cosmos

pkg_name=libxfontcache
pkg_version=1.0.5
pkg_description="X11 font cache library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxext' 'fontcacheproto')
pkg_build_deps=('pkgconfig')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXfontcache-${pkg_version}.tar.bz2"
        'LICENSE')
pkg_shasum=('bbd37768c87f63cf2eb845b2c0f56515'
         '152d5429e5292e8098c667e0d0d22f01')

do_build() {
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --disable-static \
        --build=${CHOST} \
        --host=${CHOST}
  make 
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ../LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
