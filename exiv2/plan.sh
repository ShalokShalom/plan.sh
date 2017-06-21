pkg_origin=cosmos

pkg_name=exiv2
pkg_version=0.26
pkg_description="Exif and Iptc metadata manipulation library and tools."
pkg_upstream_url="http://exiv2.org"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'zlib' 'expat')
pkg_source=("http://exiv2.org/builds/${pkg_name}-${pkg_version}-trunk.tar.gz")
pkg_shasum=('a171314cbd6535a356c8a7297ea8c5e7')

do_build() {
  
  #CPPFLAGS="-D_FILE_OFFSET_BITS=64" 
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
