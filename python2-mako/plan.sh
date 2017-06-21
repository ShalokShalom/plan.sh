pkg_origin=cosmos

pkg_name=python2-mako
_pkg_name=mako
pkg_version=1.0.6
_pkg_version=1_0_6
pkg_description="Template library written in Python to provide a familiar, non-XML syntax which compiles into Python modules for maximum performance"
pkg_upstream_url="http://www.makotemplates.org/"
pkg_license=('MIT')
pkg_deps=('python2-setuptools' 'python2-markupsafe')
pkg_source=("https://github.com/zzzeek/mako/archive/rel_${_pkg_version}.tar.gz")
pkg_shasum=('d345f04e6389e23619f23221e612584e')

do_build() {

    python2 setup.py build
}

do_package() {
    python2 setup.py install --root=${CACHE_PATH} --optimize=1

    install -D LICENSE ${CACHE_PATH}/usr/share/licenses/python-mako/COPYING
}
