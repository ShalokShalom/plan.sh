pkg_origin=cosmos

pkg_name=hdf5
pkg_version=1.10.1
_patchver=1.10.1
_pkg_version=1.10
pkg_description="General purpose library and file format for storing scientific data"
pkg_upstream_url="https://www.hdfgroup.org/HDF5/"
pkg_license=('custom')
pkg_deps=('zlib' 'sh')
pkg_source=("https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-${_pkg_version}/hdf5-${_patchver}/src/${pkg_name}-${_patchver}.tar.bz2")
pkg_shasum=('d89893c05ee7ea8611b51bb39450d64e')

do_build() {
  
  ./configure --prefix=/usr \
    --disable-static \
    --enable-hl \
    --enable-build-mode=production \
    --with-pic \
    --docdir=/usr/share/doc/hdf5/ \
    --with-pthread=/usr/lib/ \
    --disable-sharedlib-rpath
  make 
}

do_package() {

  make -j1 prefix=${pkg_prefix}/usr install

  install -d -m755 ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE 
}

