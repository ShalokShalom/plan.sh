pkg_origin=cosmos

pkg_name=0ad-data
_pkg_name=0ad
pkg_version=a21
_pkg_version=0.0.21-alpha
pkg_description="Cross-platform, 3D and historically-based real-time strategy game (data files)"
pkg_upstream_url="http://play0ad.com/"
pkg_license=('GPL2' 'CCPL')
pkg_source=("http://releases.wildfiregames.com/${_pkg_name}-${_pkg_version}-unix-data.tar.xz")
pkg_shasum=('d42b04e1f65d45b5a4bbf8fcea6076f8')

do_package(){

  install -d ${pkg_prefix}/usr/share/${_pkg_name}/data

  cp -r ${CACHE_PATH}/${_pkg_name}-${_pkg_version}/binaries/data ${pkg_prefix}/usr/share/${_pkg_name}
}
