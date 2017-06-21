pkg_origin=cosmos

pkg_name=libplist
pkg_version=2.0.0
pkg_description="A library to handle Apple Property List format whereas it's binary or XML"
pkg_upstream_url="http://libimobiledevice.org/"
pkg_license=('GPL2' 'LGPL2.1')
pkg_deps=('glib2' 'libxml2')
pkg_build_deps=('python2')
pkg_source=("http://www.libimobiledevice.org/downloads/$pkg_name-$pkg_version.tar.bz2")
pkg_shasum=('16fb70d869f66e23cbe140109e78b650')

do_build() {
  
  ./configure --prefix=/usr  
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
