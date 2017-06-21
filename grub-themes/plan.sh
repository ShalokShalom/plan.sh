pkg_origin=cosmos

pkg_name=grub-theme-midna
_pkg_name=midna
pkg_version=3.0
pkg_description="Midna Grub-theme."
pkg_upstream_url="http://kaosx.us"
pkg_license=('GPL' 'CC-SA')
pkg_deps=('grub-common')
install=grub-themes.install
pkg_source=("http://sourceforge.net/projects/kaosx/files/sources/grub-themes/${_pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('16f248ce02508a077d1357840e58902d')
 
do_package() {
  cd ${CACHE_PATH}
  
  install -dm755 ${pkg_prefix}/usr/share/grub/themes
  cp -dpr --no-preserve=ownership ${_pkg_name} ${pkg_prefix}/usr/share/grub/themes
}
