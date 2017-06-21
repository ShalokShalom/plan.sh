pkg_origin=cosmos

pkg_name=tinyxml
pkg_version=2.6.2
pkg_description='Simple, small, C++ XML parser that can be easily integrated into other programs'
pkg_upstream_url="http://www.grinninglizard.com/tinyxml/"
pkg_license=('zlib')
pkg_deps=('gcc-libs')
pkg_source=("http://downloads.sourceforge.net/tinyxml/${pkg_name}_${pkg_version//./_}.tar.gz"
        'entity.patch'
        'tinyxml-2.5.3-stl.patch'
        'tinyxml.pc')
pkg_shasum=('c1b864c96804a10526540c664ade67f0'
         'b6cc2d9330707373d920f760793c6311'
         '6db8334398e0cdad7e3c6406206ff42a'
         '9c6788d9e2e8485ffbd7d8e0e8da940d')

do_build() {
  patch -p0 -i ${CACHE_PATH}/entity.patch
  patch -p1 -i ${CACHE_PATH}/${pkg_name}-2.5.3-stl.patch

  # Fix Makefile
  sed -i \
    -e '/^TINYXML_USE_STL/ s|=.*|=YES|' \
    -e "s|^RELEASE_CFLAGS.*|& ${CXXFLAGS} -fPIC|" Makefile

  make
  g++ -fPIC "$CXXFLAGS" -shared -o "lib${pkg_name}.so.0.${pkg_version}" \
      -Wl,-soname,"lib${pkg_name}.so.0" $(ls *.o | grep -v xmltest)
}

do_package() {

  install -d -m 0755 ${CACHE_PATH}/usr/{lib,include}
  install -m 0755 lib${pkg_name}.so.0.${pkg_version} ${CACHE_PATH}/usr/lib/
  install -m 0644 ${pkg_name}.h tinystr.h ${CACHE_PATH}/usr/include
  install -Dm644 readme.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
  install -Dm644 ${CACHE_PATH}/${pkg_name}.pc ${CACHE_PATH}/usr/lib/pkgconfig/${pkg_name}.pc

  (cd ${CACHE_PATH}/usr/lib
    ln -s "lib${pkg_name}.so.0.${pkg_version}" "lib${pkg_name}.so.0"
    ln -s "lib${pkg_name}.so.0.${pkg_version}" "lib${pkg_name}.so"
  )
}

