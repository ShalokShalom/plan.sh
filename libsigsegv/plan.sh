pkg_origin=cosmos

pkg_name=libsigsegv
pkg_version=2.11
pkg_description="Page fault detection library"
pkg_upstream_url="https://www.gnu.org/software/libsigsegv/"
pkg_license=('GPL2')
pkg_deps=('glibc')
pkg_source=("https://ftp.gnu.org/gnu/libsigsegv/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('a812d9481f6097f705599b218eea349f')

do_build() {
  
  ./configure --prefix=/usr --enable-shared
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
