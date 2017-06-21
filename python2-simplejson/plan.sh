pkg_origin=cosmos

pkg_name=python2-simplejson
pkg_version=3.10.0
pkg_description='Simple, fast, extensible JSON encoder/decoder for Python'
pkg_license=('MIT')
pkg_upstream_url='https://github.com/simplejson/simplejson'
pkg_deps=('python2')
pkg_build_deps=('python2-setuptools' 'git')
pkg_source=("https://github.com/simplejson/simplejson/archive/v${pkg_version}.tar.gz")
pkg_shasum=('c330d5f5ab86e0239911b72a4401f97b')

do_package() {
    python2 setup.py install --root=${CACHE_PATH}
    
    install -Dm644 LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
} 
