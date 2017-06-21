pkg_origin=cosmos

pkg_name=xvidcore
pkg_version=1.3.4
pkg_description="XviD is an open source MPEG-4 video codec"
pkg_license=('GPL')
pkg_upstream_url="https://www.xvid.org/"
pkg_deps=('glibc')
pkg_build_deps=('nasm')
pkg_source=("http://downloads.xvid.org/downloads/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('5e68b84e3286b7bbaa95ddc34f0fcace')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  #Fix dynamic libraries
  _mylib=$(basename libxvidcore.so.*)
  ln -sf ${_mylib} libxvidcore.so.4
  ln -sf ${_mylib} libxvidcore.so
}
