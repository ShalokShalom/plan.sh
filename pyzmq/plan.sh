pkg_origin=cosmos
 
pkg_name=pyzmq
pkg_version=16.0.2
pkg_description="Python bindings for ØMQ, a lightweight and fast messaging implementation."
pkg_upstream_url="http://www.zeromq.org/bindings:python"
pkg_license=('LGPL')
pkg_deps=('zeromq' 'python3')
pkg_build_deps=('python3-cython')
pkg_source=("https://github.com/zeromq/pyzmq/archive/v${pkg_version}.tar.gz")
pkg_shasum=('4cf14a2995742253b2b009541f4436f4')

do_package() {
  
  python3 setup.py install --root=${CACHE_PATH} --optimize=0
}


