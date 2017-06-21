pkg_origin=cosmos

pkg_name=hwloc
pkg_version=1.11.7
pkg_description="Portable Hardware Locality is a portable abstraction of hierarchical architectures"
pkg_upstream_url="https://www.open-mpi.org/projects/hwloc/"
pkg_license=('BSD')
pkg_deps=('sh' 'pciutils' 'libxml2' 'cairo')
pkg_build_deps=('pkg-config')
pkg_source=("https://www.open-mpi.org/software/hwloc/v1.11/downloads/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('13d2e4dbce392cda41f1451d386d9a45')

do_build() {
   
   ./configure --prefix=/usr
   make
}

do_package() {
   
   make DESTDIR=${pkg_prefix} install
   install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

