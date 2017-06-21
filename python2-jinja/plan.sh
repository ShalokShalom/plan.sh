pkg_origin=cosmos

pkg_name=python2-jinja
pkg_version=2.9.6
pkg_description="A simple pythonic template language written in Python"
pkg_upstream_url="http://jinja.pocoo.org/2/"
pkg_license=('BSD')
pkg_deps=('python2-markupsafe' 'python2-setuptools')
pkg_build_deps=('python2')
pkg_source=("https://github.com/pallets/jinja/archive/${pkg_version}.tar.gz")
pkg_shasum=('47c4cd258d6fa77aaa2b281d1db3e35b')

do_package() {

  python2 setup.py install --root=${CACHE_PATH} -O1

  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

