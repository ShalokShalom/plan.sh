pkg_origin=

pkg_name=openshot
pkg_version=2.3.4
_pkg_version=2.3
pkg_description="Non-linear video editor for Linux based on MLT framework"
pkg_upstream_url="http://www.openshotvideo.com/"
pkg_license=('GPL')
pkg_deps=('pyqt5-python3' 'ffmpeg' 'libopenshot' 'desktop-file-utils' 'python3-setuptools'
         'python3-httplib2' 'pyzmq' 'python3-requests')
pkg_source=("https://launchpad.net/openshot/${_pkg_version}/${pkg_version}/+download/${pkg_name}-qt-${pkg_version}.tar.gz")
pkg_shasum=('23efa58ec4a89ddb11af57ea06e214d6')

do_package() {
  #cd ${pkg_name}-qt-${pkg_version}
  
  python3 setup.py install --root=${pkg_prefix}/ --optimize=1
}
