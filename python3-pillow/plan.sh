pkg_origin=cosmos

pkg_name=python3-pillow
_pkg_name=Pillow
pkg_version=4.1.1
pkg_description="Python Imaging Library (PIL) fork. Python3 version."
pkg_upstream_url="http://python-pillow.github.io/"
pkg_license=('BSD')
pkg_deps=('python3' 'lcms' 'libwebp')
pkg_build_deps=('python3-setuptools' 'libwebp' 'tk' 'sane')
pkg_source=("https://github.com/python-pillow/Pillow/archive/${pkg_version}.tar.gz")
pkg_shasum=('4889a8297f4068e339cbe8878db1834c')

do_package() {
  python3 setup.py install --root=${CACHE_PATH}/ --optimize=0
  
  install -Dm644 docs/COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
