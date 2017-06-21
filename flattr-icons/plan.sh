pkg_origin=

pkg_name=flattr-icons
_pkg_name=flattr-icons-kde
pkg_version=0.9.19
pkg_description='Flattr Icon theme, designed and developed by Uri Herrera, adjusted for KaOS'
pkg_upstream_url='http://store.nitrux.in/'
pkg_license=('cc-by-nc-nd-4.0')
pkg_build_deps=('git')
pkg_source=("https://github.com/KaOSx/flattr-icons-kde/archive/master.zip")
pkg_shasum=('9bdda248cf4f6b279d6b206b53d77907')

do_package() {
  mkdir -p ${pkg_prefix}/usr/share/icons/flattr-icons-kde
  cp -r ${_pkg_name}-master/* ${pkg_prefix}/usr/share/icons/flattr-icons-kde/
  
  install -Dm644 ${_pkg_name}-master/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
