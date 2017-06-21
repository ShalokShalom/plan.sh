pkg_origin=

# only build local, server for unknown reasons does not follow perl install dir
pkg_name=image-exiftool
_pkg_name=Image-ExifTool
pkg_version=10.55
pkg_description="Platform-independent Perl library plus a command-line application for reading, writing and editing meta information in a wide variety of files."
pkg_upstream_url="http://www.sno.phy.queensu.ca/~phil/exiftool/"
pkg_license=('GPL')
pkg_deps=('perl')
pkg_source=("http://www.sno.phy.queensu.ca/~phil/exiftool/${_pkg_name}-$pkg_version.tar.gz")
pkg_shasum=('925fa97c439efd7dd93b88046729dcec')

do_build() {
  cd ${_pkg_name}-${pkg_version}
  
  perl Makefile.PL INSTALLDIRS=vendor 
  make
}

do_check() {
  cd ${_pkg_name}-${pkg_version}

  make test
}

do_package() {
  cd ${_pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
