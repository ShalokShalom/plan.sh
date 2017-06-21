pkg_origin=
 
pkg_name=crossguid
pkg_version=0.1
_commit=8f399e8bd4252be9952f3dfa8199924cc8487ca4
pkg_description="Minimal, cross platform, C++ GUID library."
pkg_upstream_url="https://github.com/graeme-hill/crossguid"
pkg_license=('MIT')
pkg_build_deps=('gcc')
pkg_source=("https://github.com/graeme-hill/crossguid/archive/${_commit}.zip"
        'Makefile')
pkg_shasum=('6ad78e6b402db4cbaef2554508953007'
         '5f80c7fa07d43f615804fd6c61852999')

do_build() {
  cd ${pkg_name}-${_commit}
  cp -p ${CACHE_PATH}/Makefile Makefile

  make
}

do_package() {
  cd ${pkg_name}-${_commit}
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 LICENSE "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
}
