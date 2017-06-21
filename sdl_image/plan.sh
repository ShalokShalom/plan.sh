pkg_origin=cosmos

pkg_name=sdl_image
pkg_version=1.2.12
pkg_description="Simple library to load images of various formats as SDL surfaces"
pkg_upstream_url="https://www.libsdl.org/projects/SDL_image/"
pkg_license=('custom')
pkg_deps=('sdl' 'libpng' 'libjpeg-turbo' 'libtiff' 'zlib')
pkg_source=("https://www.libsdl.org/projects/SDL_image/release/SDL_image-${pkg_version}.tar.gz")
pkg_shasum=('a0f9098ebe5400f0bdc9b62e60797ecb')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make 
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
