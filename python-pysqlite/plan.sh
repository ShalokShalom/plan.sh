pkg_origin=cosmos

pkg_name=python-pysqlite
pkg_version=2.8.3
pkg_description="A Python DB-API 2.0 interface for the SQLite embedded relational database engine"
pkg_license=('custom')
pkg_upstream_url="https://github.com/ghaering/pysqlite"
pkg_deps=('python2' 'sqlite')
pkg_source=("https://pypi.io/packages/source/p/pysqlite/pysqlite-${pkg_version}.tar.gz"
        'setup.cfg')
pkg_shasum=('033f17b8644577715aee55e8832ac9fc'
         '86dd356c65afd14a22f2f8f64a26441e')
do_build() {
	cp ${CACHE_PATH}/setup.cfg .
	
	python2 setup.py build
}

do_package() {
	python2 setup.py install --root="${CACHE_PATH}"
	
	install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
	rm -r ${CACHE_PATH}/usr/pysqlite2-doc
}
