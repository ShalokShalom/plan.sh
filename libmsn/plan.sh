pkg_origin=cosmos

pkg_name=libmsn
pkg_version=4.2.1
pkg_description="A reusable, open-source, fully documented library for connecting to Microsoft's MSN"
pkg_upstream_url="http://sourceforge.net/projects/libmsn/"
pkg_license=('GPL2')
pkg_deps=('openssl')
pkg_build_deps=('cmake')
pkg_source=("http://downloads.sourceforge.net/$pkg_name/$pkg_name-$pkg_version.tar.bz2"
        'gcc47.diff')
pkg_shasum=('38e46e589720eefd71f92b6b76993bf0'
         'c1eb66d32fdcc69de2a6ec0756514081')

do_build() {
  patch -p1 -i "${CACHE_PATH}/gcc47.diff"
  
  mkdir build
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release
  make
}

do_package() {
  
  make "DESTDIR=${pkg_prefix}" install
}

