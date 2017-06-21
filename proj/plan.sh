pkg_origin=cosmos

pkg_name=proj
pkg_version=4.9.3
pkg_description="Cartographic Projections library"
pkg_upstream_url="http://trac.osgeo.org/proj/"
pkg_license=('MIT')
pkg_source=("http://download.osgeo.org/proj/${pkg_name}-${pkg_version}.tar.gz"
        "http://download.osgeo.org/proj/${pkg_name}-datumgrid-1.6.zip")
pkg_shasum=('d598336ca834742735137c5674b214a1'
         '4dc75812515cfa744032bbf888c5caee')

do_build() {
  bsdtar -xzvf ${CACHE_PATH}/${pkg_name}-datumgrid-1.6.zip -C ${CACHE_PATH}/proj-${pkg_version}/nad

  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -D COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
