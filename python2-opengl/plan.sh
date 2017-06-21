pkg_origin=cosmos

pkg_name=python2-opengl
pkg_version=3.0.2
pkg_description="The cross platform Python binding to OpenGL and related APIs"
pkg_license=('BSD')
pkg_deps=('python2' 'tk' 'freeglut' 'python2-setuptools')
pkg_upstream_url="http://pyopengl.sourceforge.net"
pkg_source=("http://pypi.python.org/packages/source/P/PyOpenGL/PyOpenGL-${pkg_version}.tar.gz"
        'LICENSE')
pkg_shasum=('77becc24ffc0a6b28030aa109ad7ff8b'
         '0b53c508a63e5dbaf44cdfb0fa103b3a')

do_build() {
  /bin/true
}

do_package() {
  python2 setup.py install --root=${CACHE_PATH} --optimize=1
  
  install -Dm644 ${CACHE_PATH}/LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
