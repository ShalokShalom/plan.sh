pkg_origin=cosmos
pkg_name=gperf
pkg_version=3.1
pkg_description="Perfect hash function generator."
pkg_upstream_url="http://www.gnu.org/software/gperf/"
pkg_license=('GPL3')
pkg_deps=('core/gcc-libs' 'core/texinfo')
pkg_build_deps=('core/gcc' 'core/make')
pkg_source=("ftp://ftp.gnu.org/gnu/gperf/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=588546b945bba4b70b6a3a616e80b4ab466e3f33024a352fc2198112cdbb3ae2


do_build() {
  
  ./configure --prefix=/usr \
    --docdir=/usr/share/gperf/doc/
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
