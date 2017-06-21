pkg_origin=cosmos

pkg_name=libass
pkg_version=0.13.7
pkg_description="A portable library for SSA/ASS subtitles rendering"
pkg_upstream_url="https://github.com/libass/libass"
pkg_license=('GPL')
pkg_deps=('enca' 'fontconfig' 'fribidi' 'harfbuzz')
pkg_build_deps=('pkg-config' 'yasm')
pkg_source=("https://github.com/libass/libass/archive/${pkg_version}.tar.gz")
pkg_shasum=('8344b33e0703e5c670a29217f73b5b48')

do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
