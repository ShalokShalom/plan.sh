pkg_origin=cosmos

pkg_name=libspatialite
pkg_version=4.3.0.1
_pkg_version=4.3.0a
pkg_description="SQLite extension to support spatial data types and operations"
pkg_upstream_url="https://www.gaia-gis.it/fossil/libspatialite/index"
pkg_license=('MPL')
pkg_deps=('geos' 'proj' 'sqlite3' 'libfreexl' 'zlib')
pkg_source=("http://www.gaia-gis.it/gaia-sins/${pkg_name}-sources/${pkg_name}-${_pkg_version}.tar.gz")
pkg_shasum=('6b380b332c00da6f76f432b10a1a338c')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix}/ install
}
