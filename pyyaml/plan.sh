pkg_origin=cosmos
 
pkg_name=pyyaml
_pkg_name=PyYAML
pkg_version=3.12
pkg_description="The next generation YAML parser and emitter for Python."
pkg_upstream_url="https://bitbucket.org/xi/pyyaml"
pkg_license=('MIT')
pkg_deps=('python3' 'libyaml')
pkg_source=("http://pyyaml.org/download/pyyaml/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('4c129761b661d181ebf7ff4eb2d79950')

do_package() {
  
  python3 setup.py install --prefix=/usr --root=${CACHE_PATH}
  install -m644 -D LICENSE ${CACHE_PATH}/usr/share/licenses/$pkg_name/LICENSE
}

