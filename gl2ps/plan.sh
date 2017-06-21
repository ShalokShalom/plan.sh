pkg_origin=cosmos

pkg_name=gl2ps
pkg_version=1.3.9
pkg_description="C library providing high quality vector output for any OpenGL application."
pkg_upstream_url='http://geuz.org/gl2ps/'
pkg_license=('LGPL')
pkg_deps=('libpng' 'freeglut' 'glu')
pkg_build_deps=('cmake' 'texlive-core')
pkg_source=("http://geuz.org/gl2ps/src/${pkg_name}-${pkg_version}.tgz")
pkg_shasum=('377b2bcad62d528e7096e76358f41140')

do_build() {
  mkdir build

  cmake ../${pkg_name}-$pkg_version-source \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_EXE_LINKER_FLAGS=-lm
  make
}

do_package() {

  make DESTDIR=$pkg_prefix/ install
}
