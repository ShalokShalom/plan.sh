pkg_origin=cosmos

pkg_name=sip3
_pkg_name=sip
pkg_version=4.19.2
_pkg_version=4.19.2
pkg_description="Tool that makes it easy to create Python3 bindings for C and C++ libraries"
pkg_upstream_url="http://www.riverbankcomputing.com/software/sip/"
pkg_license=('custom:"sip"')
pkg_deps=('python3' 'gcc-libs')
pkg_source=("http://sourceforge.net/projects/pyqt/files/sip/sip-${pkg_version}/${_pkg_name}-${pkg_version}.tar.gz")
#pkg_source=("http://www.riverbankcomputing.com/static/Downloads/sip4/sip-${pkg_version}.tar.gz")
pkg_shasum=('4f48e212890ebe584e8d804cfbcfc61e')

do_build() {

  python3 configure.py
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install 
  
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
