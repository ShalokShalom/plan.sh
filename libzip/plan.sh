pkg_origin=cosmos

pkg_name=libzip
pkg_version=1.2.0
pkg_description="A C library for reading, creating, and modifying zip archives"
pkg_upstream_url="http://www.nih.at/libzip/index.html"
pkg_license=('GPL2')
pkg_deps=('zlib')
pkg_source=("http://www.nih.at/libzip/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('2a9b316d16218f1b7562d5a5e0fcbd79')

do_build() {
  #patch -p1 -i ${CACHE_PATH}/optopt.patch
  
  autoreconf -i
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  # ebook-tools needs this path
  ln -s /usr/lib/libzip/include/zipconf.h ${pkg_prefix}/usr/include/zipconf.h
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
