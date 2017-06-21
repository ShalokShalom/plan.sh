pkg_origin=cosmos

pkg_name=python3-jinja
pkg_version=2.9.6
pkg_description="A simple pythonic template language written in Python"
pkg_upstream_url="http://jinja.pocoo.org/2/"
pkg_license=('BSD')
pkg_deps=('python3-markupsafe' 'python3-setuptools')
pkg_build_deps=('python3')
pkg_source=("https://github.com/pallets/jinja/archive/${pkg_version}.tar.gz")
pkg_shasum=('47c4cd258d6fa77aaa2b281d1db3e35b')

do_package() {

  python3 setup.py install --root=${CACHE_PATH} -O1

  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

