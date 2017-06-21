pkg_origin=cosmos

pkg_name=sip
pkg_version=4.19.2
_pkg_version=4.19.2
_snapshot=0b19f77489ce
pkg_description="A tool that makes it easy to create Python2 bindings for C and C++ libraries"
pkg_upstream_url="http://www.riverbankcomputing.com/software/sip/"
pkg_license=('custom:"sip"')
pkg_deps=('python2' 'gcc-libs' 'sip3')
pkg_source=("http://sourceforge.net/projects/pyqt/files/sip/sip-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
#pkg_source=("http://www.riverbankcomputing.com/static/Downloads/sip4/sip-${pkg_version}.tar.gz")
#pkg_source=("http://www.riverbankcomputing.com/static/Downloads/sip4/sip-4.15.5-snapshot-$_snapshot.tar.gz")
pkg_shasum=('4f48e212890ebe584e8d804cfbcfc61e')

do_build() {
  #cd ${pkg_name}-4.15.5-snapshot-$_snapshot 

  python2 configure.py
  make
}

do_package() {
  #cd ${pkg_name}-4.15.5-snapshot-$_snapshot

  make DESTDIR=${CACHE_PATH} install -C siplib
  
  install -Dm644 sipconfig.py ${CACHE_PATH}/usr/lib/python2.7/site-packages/sipconfig.py
  install -Dm644 sipdistutils.py ${CACHE_PATH}/usr/lib/python2.7/site-packages/sipdistutils.py 
  
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
