pkg_origin=cosmos

pkg_name=xmldiff
pkg_version=0.6.10
pkg_description="A python tool that figures out the differences between two similar XML files, in the same way the diff utility does it"
pkg_upstream_url="http://www.logilab.org/project/xmldiff/"
pkg_license=('GPL2')
pkg_deps=('python2' 'libxslt' 'jade')
optpkg_deps=('docbook-xsl: render revision info')
groups=('programming')
pkg_source=("ftp://mirror.us.leaseweb.net/gentoo/distfiles/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('a61e6e95a130e3bd53f5ea5616cc5314')

do_build() {
  
  python2 setup.py build
}

do_package() {
  python2 setup.py install --root=${CACHE_PATH}/ --optimize=1
  
  install -m755 -d ${CACHE_PATH}/usr/share/man/man1
  install -m644 man/*.1 ${CACHE_PATH}/usr/share/man/man1
}
