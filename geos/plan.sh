pkg_origin=cosmos

pkg_name=geos
pkg_version=3.6.1
pkg_description="A C++ port of the Java Topology Suite"
pkg_upstream_url="http://trac.osgeo.org/geos/"
pkg_license=('LGPL')
pkg_deps=('gcc-libs' 'bash')
pkg_source=("http://download.osgeo.org/geos/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('c97e338b3bc81f9848656e9d693ca6cc')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

