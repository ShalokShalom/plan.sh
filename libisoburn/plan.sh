pkg_origin=cosmos

pkg_name=libisoburn
pkg_version=1.4.6
pkg_description="Frontend for libraries libburn and libisofs which enables creation and expansion of ISO-9660 filesystems"
pkg_upstream_url="https://dev.lovelyhq.com/libburnia/web/wikis/home"
pkg_license=('GPL2')
pkg_deps=('libburn>=1.4.6' 'libisofs>=1.4.6' 'readline')
pkg_deps=('tk: for xorriso-tcltk frontend')
pkg_source=("http://files.libburnia-project.org/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('15d763fd698b9bc8d6fc643a3257505b')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
