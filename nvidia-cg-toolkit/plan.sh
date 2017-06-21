pkg_origin=cosmos

pkg_name=nvidia-cg-toolkit 
pkg_version=3.1
_date="April2012"
pkg_description="NVIDIA Cg libraries" 
pkg_upstream_url="http://developer.nvidia.com/object/cg_toolkit.html" 
pkg_license=('custom')
pkg_deps=('glibc') 
pkg_source=("http://developer.download.nvidia.com/cg/Cg_${pkg_version}/Cg-${pkg_version}_${_date}_x86_64.tgz")
pkg_shasum=('88ba727cdbe0261fac465c4d84f44762')

do_build() {
  return 0
}

do_package() { 
  install -Dm755 ${CACHE_PATH}/usr/bin/cgc ${pkg_prefix}/usr/bin/cgc
  install -dm755 ${pkg_prefix}/usr/include/Cg
  install -m644 ${CACHE_PATH}/usr/include/Cg/* ${pkg_prefix}/usr/include/Cg
  install -dm755 ${pkg_prefix}/usr/lib
  install -m644 ${CACHE_PATH}/usr/lib64/* ${pkg_prefix}/usr/lib
  install -Dm644 ${CACHE_PATH}/usr//local/Cg/docs/license.txt ${pkg_prefix}/usr/share/licenses/nvidia-cg-toolkit/license.txt
  cp -r ${CACHE_PATH}/usr/local/Cg ${pkg_prefix}/usr/share/
  find $pkg_prefix/usr/share/ -type d -exec chmod -R 755 '{}' ';'
  find $pkg_prefix/usr/share/ -type f -exec chmod -R 644 '{}' ';'
}
