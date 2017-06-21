pkg_origin=cosmos

pkg_name=python2-twisted
_pkg_name=Twisted
pkg_version=12.2.0
pkg_description="Asynchronous networking framework written in Python"
pkg_upstream_url="http://twistedmatrix.com/"
pkg_license=('MIT')
pkg_deps=('python2' 'python2-crypto' 'python2-zope-interface')
optpkg_deps=('pyopenssl'
            'python-soappy: for twisted.web.soap')
install=${pkg_name}.install
pkg_source=(http://twistedmatrix.com/Releases/${_pkg_name}/${pkg_version%.*}/${_pkg_name}-${pkg_version}.tar.bz2
        4771.diff)
pkg_shasum=('9a321b904d01efd695079f8484b37861'
         '087ed6149abca43919dcece24ba222ab')
do_build() {

  python2 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1
  install -D -m644 LICENSE "${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE"

  sed -e 's|#!/usr/bin/env python|#!/usr/bin/env python2|' \
      -i ${CACHE_PATH}/usr/lib/python2.7/site-packages/twisted/trial/test/scripttest.py
  sed -e 's|#!/usr/bin/env python|#!/usr/bin/env python2|' \
      -i ${CACHE_PATH}/usr/lib/python2.7/site-packages/twisted/mail/test/pop3testserver.py
}
