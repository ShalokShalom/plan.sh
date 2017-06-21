pkg_origin=cosmos

pkg_name=python2-m2crypto
pkg_version=0.25.1
pkg_description="A crypto and SSL toolkit for Python"
pkg_upstream_url="https://gitlab.com/m2crypto/m2crypto"
pkg_license=('BSD')
pkg_deps=('python2' 'openssl')
pkg_build_deps=('swig' 'python2-distribute')
pkg_source=("https://pypi.python.org/packages/9c/58/7e8d8c04995a422c3744929721941c400af0a2a8b8633f129d92f313cfb8/M2Crypto-${pkg_version}.tar.gz"
        "https://gitlab.com/m2crypto/m2crypto/raw/master/LICENCE")
pkg_shasum=('040234289fbef5bed4029f0f7d1dae35'
         'b0e1f0b7d0ce8a62c18b1287b991800e')

do_build() {
  cd M2Crypto-${pkg_version}
   
  python setup.py build
}

do_package() {
  cd M2Crypto-${pkg_version}
  
  python2 setup.py install --root=${pkg_prefix}/ --optimize=1

  install -D -m644 ${CACHE_PATH}/LICENCE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
