pkg_origin=cosmos
 
pkg_name=python2-psutil
pkg_version=5.2.2
pkg_description='Cross-platform process and system utilities module for Python'
pkg_upstream_url='https://github.com/giampaolo/psutil'
pkg_license=('custom: BSD')
pkg_deps=('python2-setuptools')
pkg_source=("https://github.com/giampaolo/psutil/archive/release-${pkg_version}.tar.gz")
pkg_shasum=('8beb3d9c3aef1ebd562cb7394463c2b1')

do_package() {
  
  python2 setup.py install --root=${CACHE_PATH} --optimize=1
  
  install -D -m 644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
