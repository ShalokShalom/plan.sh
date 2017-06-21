pkg_origin=cosmos

pkg_name=python3-astroid
pkg_version=1.5.3
pkg_description="Module to provide a common base representation of python source code for projects 
         such as pychecker, pyreverse and pylint"
pkg_upstream_url="https://github.com/pycqa/astroid"
pkg_license=('LGPL')
pkg_deps=('python3-lazy-object-proxy' 'python3-logilab-common' 'python3-six' 'python3-wrapt')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/PyCQA/astroid/archive/astroid-${pkg_version}.tar.gz")
pkg_shasum=('4438c9f7fa55bad76e9acf058e409509')


do_build() {
  
  python3 setup.py build
}

do_package() {

  python3 setup.py install --optimize=1 --skip-build --prefix=/usr --root=${CACHE_PATH}
}
