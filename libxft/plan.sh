pkg_origin=cosmos

pkg_name=libxft
pkg_version=2.3.2
pkg_description="FreeType-based font drawing library for X"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('fontconfig' 'libxrender')
pkg_build_deps=('pkgconfig')
pkg_source=(${url}/releases/individual/lib/libXft-${pkg_version}.tar.bz2)
pkg_shasum=('331b3a2a3a1a78b5b44cfbd43f86fcfe')

do_build() {
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  install -d -m755 "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"

}
