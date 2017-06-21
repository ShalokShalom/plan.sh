pkg_origin=cosmos
 
pkg_name=optipng
pkg_version=0.7.6
pkg_description="PNG optimizer that recompresses image files to a smaller size, without losing any information."
pkg_upstream_url="http://optipng.sourceforge.net"
pkg_license=('ZLIB')
pkg_deps=('libpng' 'zlib')
pkg_source=("https://sourceforge.net/projects/optipng/files/OptiPNG/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('568e0738358450eca69ecf578d48f26c')

do_build() {
  
  ./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --with-system-libs
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
