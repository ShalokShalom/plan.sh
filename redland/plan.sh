pkg_origin=cosmos

pkgbase=redland
pkg_name=('redland' 'redland-storage-mysql' 'redland-storage-postgresql' 'redland-storage-virtuoso' 'redland-storage-sqlite')
pkg_version=1.0.17
pkg_upstream_url="http://librdf.org/"
pkg_license=("GPL")
pkg_build_deps=('rasqal' 'raptor' 'db' 'postgresql-libs' 'mariadb' 'unixodbc' 'sqlite3')
pkg_source=("http://download.librdf.org/source/$pkg_name-$pkg_version.tar.gz"
        'rpath.diff')
pkg_shasum=('e5be03eda13ef68aabab6e42aa67715e'
         'acc85e784f01a656bd56777f95880787')

do_build() {
  ./configure --prefix=/usr \
	--enable-release \
	--disable-static \
        --disable-gtk-doc \
	--with-raptor=system \
	--with-rasqal=system \
	--with-sqlite=3

  patch -p0 -i ${CACHE_PATH}/rpath.diff

  make
}

package_redland() {
 pkg_description="Library that provides a high-level interface to RDF data"
 pkg_deps=('rasqal>=0.9.30' 'raptor>=2.0.9' 'libltdl')
 
  make DESTDIR=${CACHE_PATH} install
  rm -rf ${CACHE_PATH}/usr/lib/redland
}

package_redland-storage-mysql() {
 pkg_description="MySQL storage support for Redland"
 pkg_deps=('redland' 'mariadb')

  install -dm755 ${CACHE_PATH}/usr/lib/redland
  install -m755 src/.libs/librdf_storage_mysql.so ${CACHE_PATH}/usr/lib/redland/librdf_storage_mysql.so 
}

package_redland-storage-postgresql() {
 pkg_description="PostgreSQL storage support for Redland"
 pkg_deps=('redland' 'postgresql-libs')

  install -dm755 ${CACHE_PATH}/usr/lib/redland
  install -m755 src/.libs/librdf_storage_postgresql.so ${CACHE_PATH}/usr/lib/redland/
}

package_redland-storage-virtuoso() {
 pkg_description="Virtuoso storage support for Redland"
 pkg_deps=('redland' 'unixodbc' 'db')

  install -dm755 ${CACHE_PATH}/usr/lib/redland
  install -m755 src/.libs/librdf_storage_virtuoso.so ${CACHE_PATH}/usr/lib/redland/
}

package_redland-storage-sqlite() {
 pkg_description="SQLite storage support for Redland"
 pkg_deps=('redland' 'sqlite3' 'db')
 
  install -dm755 ${CACHE_PATH}/usr/lib/redland
  install -m755 src/.libs/librdf_storage_sqlite.so ${CACHE_PATH}/usr/lib/redland/
}
