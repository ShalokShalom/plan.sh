pkg_origin=cosmos

pkg_name=python2-setuptools
pkg_version=36.0.1
pkg_description="Easily download, build, install, upgrade, and uninstall Python packages"
pkg_license=('PSF')
pkg_upstream_url="http://pypi.python.org/pypi/setuptools"
pkg_deps=('python2-appdirs' 'python2-packaging')
pkg_build_deps=('asciidoc' 'python2-pip')
pkg_source=("https://github.com/pypa/setuptools/archive/v${pkg_version}.tar.gz")
pkg_shasum=('45990d602eaff615b78592e40918e96b')

do_build() {
   sed -i '/pip.main(args)/d' bootstrap.py
   
   python2 bootstrap.py
   python2 setup.py build
}
 
do_check() {
   # test fail in chroot LC_CTYPE=en_US.utf8 fixes tests on installed system
   #python2 setup.py test
}
 
do_package() {
   
   python2 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
}
 

