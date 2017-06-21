pkg_origin=cosmos

pkg_name=chrpath
pkg_version=0.16
pkg_description="Allows you to modify the dynamic library load path"
pkg_upstream_url="http://directory.fsf.org/project/chrpath/"
pkg_license=('GPL2')
pkg_deps=('glibc')
pkg_source=("https://alioth.debian.org/frs/download.php/file/3979/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2bf8d1d1ee345fc8a7915576f5649982')

do_build() {
  
  ./configure --prefix=/usr --mandir=/usr/share/man
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} docdir=/usr/share/doc/chrpath install
}
