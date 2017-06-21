pkg_origin=cosmos

pkg_name=python3-setuptools
pkg_version=36.0.1
pkg_description="Easily download, build, install, upgrade, and uninstall Python3 packages"
pkg_license=('PSF')
pkg_upstream_url="http://pypi.python.org/pypi/setuptools"
pkg_deps=('python3-appdirs' 'python3-packaging')
pkg_build_deps=('asciidoc' 'python3-pip')
pkg_source=("https://github.com/pypa/setuptools/archive/v${pkg_version}.tar.gz")
pkg_shasum=('45990d602eaff615b78592e40918e96b')

do_build() {
   sed -i -e "s|^#\!.*/usr/bin/env python|#!/usr/bin/env python3|" setuptools/command/easy_install.py
   sed -i '/pip.main(args)/d' bootstrap.py
   
   python3 bootstrap.py
   python3 setup.py build
}
 
do_check() {
   
   #python3 setup.py test
}
 
do_package() {
   
   python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
   rm ${CACHE_PATH}/usr/bin/easy_install
}
 

