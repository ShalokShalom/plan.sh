pkg_origin=cosmos

pkg_name=libvorbis
pkg_version=1.3.5
pkg_description="Vorbis codec library"
pkg_license=('custom')
pkg_upstream_url="http://www.xiph.org/ogg/vorbis/"
pkg_deps=('libogg')
pkg_source=("http://downloads.xiph.org/releases/vorbis/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('28cb28097c07a735d6af56e598e1c90f')

do_build() {

  LIBS+="-lm" ./configure --prefix=/usr --disable-static
  make
}

check() {
  
  make -j1 check
}


do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE"
}
