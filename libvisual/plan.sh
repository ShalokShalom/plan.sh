pkg_origin=cosmos

pkg_name=libvisual
pkg_version=0.4.0
pkg_description="Abstraction library that comes between applications and audio visualisation plugins"
pkg_upstream_url="http://sourceforge.net/projects/libvisual/"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/sourceforge/libvisual/libvisual-${pkg_version}.tar.gz")
pkg_shasum=('f4e78547c79ea8a8ad111cf8b85011bb')

do_build() {
   
   ./configure --prefix=/usr 
   make
}

do_package() {
   
   make DESTDIR=${pkg_prefix} install 
}
