pkg_origin=cosmos

pkg_name=libsoxr
_pkg_name=soxr
pkg_version=0.1.2
pkg_description="SoX Resampler library"
pkg_upstream_url="https://sourceforge.net/projects/soxr/"
pkg_license=('LGPL')
pkg_build_deps=('cmake' 'git')
pkg_source=("https://sourceforge.net/projects/soxr/files/soxr-${pkg_version}-Source.tar.xz")
pkg_shasum=('0866fc4320e26f47152798ac000de1c0')

do_build() {

  cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr \
        -DBUILD_TESTS=ON .
  make
}

check() {

  make test
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
