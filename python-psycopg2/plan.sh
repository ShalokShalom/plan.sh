pkg_origin=cosmos

pkgbase=python-psycopg2
pkg_name=('python3-psycopg2' 'python2-psycopg2')
pkg_version=2.7.1
pkg_description="A PostgreSQL database adapter for the Python programming language."
pkg_upstream_url="http://initd.org/psycopg/"
pkg_license=('LGPL3')
pkg_build_deps=('python2' 'python3' 'postgresql-libs>=8.4.1')
pkg_source=("http://initd.org/psycopg/tarballs/PSYCOPG-2-7/psycopg2-${pkg_version}.tar.gz")
pkg_shasum=('67848ac33af88336046802f6ef7081f3')

do_build() {
  sed -i 's/,PSYCOPG_DEBUG$//' setup.cfg
}

package_python3-psycopg2() {
  pkg_deps=('python3' 'postgresql-libs>=8.4.1')

  python3 setup.py install --root=${CACHE_PATH}
}

package_python2-psycopg2() {
  pkg_deps=('python2' 'postgresql-libs>=8.4.1')

  python2 setup.py install --root=${CACHE_PATH}
}
