pkg_origin=cosmos

pkg_name=librpcsecgss
pkg_version=0.19
pkg_description="Library for RPCSECGSS support"
pkg_upstream_url="http://www.citi.umich.edu/projects/nfsv4/linux/"
pkg_license=('GPL')
pkg_deps=('glibc' 'krb5' 'libgssglue')
pkg_build_deps=('pkg-config' 'autoconf')
pkg_source=("http://www.citi.umich.edu/projects/nfsv4/linux/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('b45ed565bdc3099023aa35830ec92997')

do_build() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  
  ./configure --prefix=/usr
  make
}

do_check() {
   cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
   
   make check
}

do_package() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  
  make DESTDIR="$pkg_prefix/" install
}
