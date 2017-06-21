pkg_origin=cosmos

pkg_name=meson
pkg_version=0.41.0
pkg_description="Open source build system meant to be both extremely fast, and as user friendly as possible."
pkg_upstream_url="http://mesonbuild.com"
pkg_license=('GPL')
pkg_deps=('ninja' 'python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/mesonbuild/meson/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('55a3b156b4a655723c6ce48f46a5c882')

#check() {
#  cd ${pkg_name}-${pkg_version}
  
#  ./run_tests.py
#}

do_package() {
  
  python3 setup.py install --prefix=/usr --root=${pkg_prefix} --optimize=1
}
