pkg_origin=cosmos

pkg_name=netcdf
pkg_version=4.4.1.1
pkg_description="Network Common Data Form interface for array-oriented data access and corresponding library."
pkg_upstream_url="https://www.unidata.ucar.edu/downloads/netcdf/index.jsp"
pkg_license=('custom')
pkg_deps=('gcc-libs' 'hdf5' 'curl')
pkg_source=("https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-${pkg_version}.tar.gz")
pkg_shasum=('503a2d6b6035d116ed53b1d80c811bda')

do_build() {
  
  ./configure --prefix=/usr \
        --enable-shared \
        --enable-netcdf-4 
  make
}

check() {
  # one test fails, known upstream https://github.com/Unidata/netcdf-c/issues/244
  make check 
}

do_package() {

  install -m755 -d ${pkg_prefix}/usr/lib
  install -m755 -d ${pkg_prefix}/usr/share/man
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYRIGHT ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYRIGHT
}
