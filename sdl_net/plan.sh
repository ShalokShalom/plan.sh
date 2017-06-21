pkg_origin=cosmos

pkg_name=sdl_net
pkg_version=1.2.8
pkg_description="Small sample cross-platform networking library"
pkg_license=('custom')
pkg_upstream_url="https://www.libsdl.org/projects/SDL_net/"
pkg_deps=('sdl')
pkg_source=("https://www.libsdl.org/projects/SDL_net/release/SDL_net-${pkg_version}.tar.gz")
pkg_shasum=('20e64e61d65662db66c379034f11f718')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
