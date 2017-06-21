pkg_origin=cosmos

pkg_name=iniparser
pkg_version=4.0
pkg_description="A free stand-alone ini file parsing library written in portable ANSI C"
pkg_upstream_url="http://ndevilla.free.fr/iniparser/"
pkg_license=('MIT')
pkg_deps=('glibc')
pkg_build_deps=('chrpath')
pkg_source=("https://github.com/ndevilla/iniparser/archive/v${pkg_version}.tar.gz"
        "https://github.com/ndevilla/iniparser/commit/5e79bf7cc786282635eb0a5a2334017d811ec1d3.diff")
pkg_shasum=('94c7278f8d22de1a31320219b27634b0'
         '4a80cb632ddc3d4d36a89e8ab4f35168')

do_build() {
  patch -p1 -i ${CACHE_PATH}/5e79bf7cc786282635eb0a5a2334017d811ec1d3.diff
  
  make
}

check() {
  
  make check
}

do_package() {
  
  install -Dm644 src/iniparser.h ${pkg_prefix}/usr/include/iniparser.h
  install -Dm644 src/dictionary.h ${pkg_prefix}/usr/include/dictionary.h
  install -Dm644 libiniparser.a ${pkg_prefix}/usr/lib/libiniparser.a
  install -Dm644 libiniparser.so.0 ${pkg_prefix}/usr/lib/libiniparser.so.0
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/iniparser/LICENSE
  
  ln -sf libiniparser.so.0 ${pkg_prefix}/usr/lib/libiniparser.so
  chrpath -d ${pkg_prefix}/usr/lib/libiniparser.so
}
