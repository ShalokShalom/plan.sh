pkg_origin=cosmos

pkg_name=libvisio
pkg_version=0.1.5
pkg_description="Library for importing Visio(tm) documents"
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/libvisio"
pkg_license=('LGPL')
pkg_deps=('libwpd' 'libwpg' 'gperf' 'librevenge')
pkg_build_deps=('boost' 'cppunit')
pkg_source=("https://dev-www.libreoffice.org/src/libvisio/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('691522167fe3b0c94becfe5d957883be')

do_build() {
  #export CPPFLAGS='-DBOOST_ERROR_CODE_HEADER_ONLY -DBOOST_SYSTEM_NO_DEPRECATED'
  
  ./configure --without-docs --prefix=/usr 
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
