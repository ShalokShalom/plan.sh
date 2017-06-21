pkg_origin=cosmos

pkg_name=python2-pillow
_pkg_name=Pillow
pkg_version=4.1.1
pkg_description="Python Imaging Library (PIL) fork. Python2 version."
pkg_upstream_url="http://python-pillow.github.io/"
pkg_license=('BSD')
pkg_deps=('python2' 'lcms' 'libwebp' 'sane')
pkg_build_deps=('python2-setuptools' 'libwebp' 'tk')
optpkg_deps=('tk: for the ImageTK module'
            'pyqt-python2: for the ImageQt module')
pkg_source=("https://github.com/python-pillow/Pillow/archive/${pkg_version}.tar.gz")
pkg_shasum=('4889a8297f4068e339cbe8878db1834c')

do_package() { 

  python2 setup.py install --root=${CACHE_PATH}/ --optimize=0
  install -Dm644 docs/COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE

  # avoid python3-pillow conflict
  for f in *.py; do
    mv "$f" "${f%.py}2"
  done
}
