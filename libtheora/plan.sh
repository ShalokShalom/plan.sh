pkg_origin=cosmos

pkg_name=libtheora
pkg_version=1.1.1
pkg_description="An open video codec developed by the Xiph.org"
pkg_upstream_url="http://www.xiph.org"
pkg_license=('BSD')
pkg_deps=('libogg')
pkg_build_deps=('libvorbis')
pkg_source=("http://downloads.xiph.org/releases/theora/libtheora-${pkg_version}.tar.bz2")
pkg_shasum=('292ab65cedd5021d6b7ddd117e07cd8e')

do_build() {
  
  ./configure --prefix=/usr --enable-shared --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 LICENSE COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
