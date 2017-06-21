pkg_origin=cosmos

pkg_name=arpack
pkg_version=3.5.0
pkg_description="Fortran77 subroutines designed to solve large scale eigenvalue problems"
pkg_upstream_url="https://github.com/opencollab/arpack-ng"
pkg_license=('BSD')
pkg_deps=('glibc' 'lapack' 'openmpi')
pkg_source=("https://github.com/opencollab/arpack-ng/archive/${pkg_version}.tar.gz")
pkg_shasum=('9762c9ae6d739a9e040f8201b1578874')

do_build() {
  
  sh bootstrap
  ./configure --prefix=/usr --enable-mpi
  make \
    F77="mpif77" \
    CFLAGS+=" `pkg-config --cflags ompi` " \
    LIBS+=" `pkg-config --libs ompi` "
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
