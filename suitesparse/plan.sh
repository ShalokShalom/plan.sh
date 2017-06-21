pkg_origin=cosmos

pkg_name=suitesparse
pkg_version=4.5.4
pkg_description="A collection of sparse matrix libraries"
pkg_upstream_url="http://faculty.cse.tamu.edu/davis/suitesparse.html"
pkg_deps=('lapack')
pkg_build_deps=('cmake')
pkg_license=('GPL')
pkg_source=("http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${pkg_version}.tar.gz")
pkg_shasum=('f6ab689442e64a1624a47aa220072d1b')

do_build() {
   export CFLAGS=" ${CFLAGS} -DNPARTITION -fPIC"
   
   make BLAS=-lblas
}


do_package() {
   install -dm755 ${CACHE_PATH}/usr
   
   make install DESTDIR=${CACHE_PATH}
   mv ${CACHE_PATH}/buildsys/main/suitesparse/src/SuiteSparse/* ${CACHE_PATH}/usr
   rm -r ${CACHE_PATH}/buildsys
   
   
   make BLAS=-lblas install INSTALL=${CACHE_PATH}/usr
}
