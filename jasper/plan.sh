pkg_origin=cosmos

pkg_name=jasper
pkg_version=2.0.12
pkg_description="Software-based implementation of the codec specified in the emerging JPEG-2000 Part-1 standard"
pkg_upstream_url="http://www.ece.uvic.ca/~mdadams/jasper/"
pkg_license=('custom:JasPer2.0')
pkg_deps=('libjpeg-turbo' 'freeglut' 'libxi' 'libxmu' 'glu')
pkg_build_deps=('cmake')
pkg_source=("http://www.ece.uvic.ca/~frodo/jasper/software/${pkg_name}-${pkg_version}.tar.gz"
        'glu.patch')
pkg_shasum=('b839a8bf418a64aa2d06413b23dd5ab3'
         'ce416e5ce438b6818ba95cab758b55e7')

prepare() {
  
  #patch -p1 -i $CACHE_PATH/glu.patch
}

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DJAS_ENABLE_SHARED=true \
    -DJAS_ENABLE_LIBJPEG=true \
    -DJAS_ENABLE_OPENGL=true \
    -DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=false
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ../${pkg_name}-${pkg_version}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
