pkg_origin=cosmos

pkg_name=rlog
pkg_version=1.4
pkg_description="Flexible message logging facility for C++ programs and libraries"
pkg_upstream_url="http://arg0.net/wiki/rlog"
pkg_license=('LGPL')
pkg_deps=('gcc-libs')
pkg_source=("https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/rlog/${pkg_name}-${pkg_version}.tar.gz"
        'rlog-section.patch')
pkg_shasum=('c29f74e0f50d66b20312d049b683ff82'
         '69644989e07ceb5c265dfc0c6f770810')

do_build() {
   patch -p1 -i ${CACHE_PATH}/rlog-section.patch 
   
   ./configure --prefix=/usr
   make 
}

do_package() {
   
   make DESTDIR=${CACHE_PATH}/ install
}
