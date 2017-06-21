pkg_origin=cosmos

pkg_name=python2-rdflib
pkg_version=4.2.1
pkg_description="A Python library for working with RDF, a simple yet powerful language for representing information"
pkg_upstream_url="http://rdflib.net/"
pkg_license=('BSD')
pkg_deps=('python2' 'python2-isodate')
pkg_build_deps=('python2-setuptools')
pkg_source=("rdflib-$pkg_version.tar.gz::https://github.com/RDFLib/rdflib/tarball/$pkg_version")
pkg_shasum=('858590faba353981d81c182e860c62cb')

do_package() {
  python2 setup.py install --root=$CACHE_PATH --optimize=1 
  
  install -D LICENSE $CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE
}
