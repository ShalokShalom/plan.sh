pkg_origin=cosmos

# rebuild kodi on every update
pkg_name=libmicrohttpd
pkg_version=0.9.55
pkg_description="Small C library that is supposed to make it easy to run an HTTP server as part of another application."
pkg_upstream_url="https://www.gnu.org/software/libmicrohttpd/"
pkg_license=('LGPL')
pkg_deps=('gnutls')
pkg_source=("https://ftp.gnu.org/gnu/libmicrohttpd/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('1c20f84a8b9cf692dd50b558b3571a3a')

do_build() {
  
  ./configure --prefix=/usr \
              --disable-dependency-tracking \
              --enable-largefile \
              --enable-curl \
              --enable-messages \
              --with-pic
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 src/include/platform.h ${pkg_prefix}/usr/include/$pkg_name/platform.h
  
  sed -i 's|Cflags: -I${includedir}|Cflags: -I${includedir} -I{includedir}/libmicrohttpd|' ${pkg_prefix}/usr/lib/pkgconfig/libmicrohttpd.pc
}
