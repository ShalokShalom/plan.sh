pkg_origin=cosmos

pkg_name=libvncserver
pkg_version=0.9.11
pkg_description="The vnc library"
pkg_upstream_url="https://libvnc.github.io/"
pkg_license=('GPL')
pkg_deps=('libjpeg-turbo' 'zlib' 'gnutls' 'libgcrypt' 'libpng')
pkg_build_deps=('sdl')
pkg_source=("https://github.com/LibVNC/libvncserver/archive/LibVNCServer-${pkg_version}.tar.gz")
pkg_shasum=('7f06104d5c009813e95142932c4ddb06')

do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
