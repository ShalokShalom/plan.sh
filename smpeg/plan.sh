pkg_origin=cosmos

pkg_name=smpeg
pkg_version=0.4.5
_pkg_version=0_4_5
pkg_description="SDL MPEG Player Library"
pkg_upstream_url="http://icculus.org/smpeg/"
pkg_license=('LGPL')
pkg_deps=('sdl')
pkg_build_deps=('glu' 'mesa')
optpkg_deps=('glu: to use glmovie')
pkg_source=("https://github.com/Distrotech/smpeg/archive/release_${_pkg_version}.tar.gz")
pkg_shasum=('e33e7f83608830efaa586990ce5e852c')

do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr \
         --mandir=/usr/share/man \
         --disable-gtk-player \
         --disable-gtktest \
         --disable-static
  make 
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
