pkg_origin=cosmos

pkg_name=libmms
pkg_version=0.6.4
pkg_description="MMS stream protocol library"
pkg_upstream_url="http://sourceforge.net/projects/libmms/"
pkg_license=('LGPL')
pkg_deps=('glib2')
pkg_source=("https://download.sourceforge.net/libmms/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d6b665b335a6360e000976e770da7691')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}


