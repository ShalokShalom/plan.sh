pkg_origin=cosmos

pkg_name=parted
pkg_version=3.2
pkg_description="A program for creating, destroying, resizing, checking and copying partitions"
pkg_license=('GPL3')
pkg_upstream_url="https://www.gnu.org/software/parted/parted.html"
pkg_deps=('device-mapper' 'e2fsprogs')
pkg_build_deps=('pkgconfig')
pkg_source=("https://ftp.gnu.org/gnu/parted/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('0247b6a7b314f8edeb618159fa95f9cb')

do_build() {

  ./configure --prefix=/usr \
    --disable-debug \
    --disable-rpath
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
