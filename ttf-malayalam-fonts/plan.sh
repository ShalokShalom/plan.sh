pkg_origin=cosmos

pkg_name=ttf-malayalam-fonts
# This variable had to be introduced to deal with the peculiar naming scheme and 
# the directory structure of the source when extracted folder
pkg_version=5.0.1
pkg_description="Set of TrueType and OpenType fonts for Malayalam Language."
pkg_upstream_url="http://smc.org.in/"
pkg_license=('GPL')
pkg_deps=('fontconfig' 'xorg-fonts-encodings')
install=ttf-malayalam-fonts.install
pkg_source=("http://download.savannah.gnu.org/releases-noredirect/smc/fonts/malayalam-fonts-${pkg_version}.zip")
pkg_shasum=('b459a03b91fd42d16c71370e21f0cf77')


do_package() {
  
  mkdir -p "${CACHE_PATH}/usr/share/fonts/TTF" 
  for f in `ls ./*/*.ttf`
  do
    install -m644 $f "${CACHE_PATH}/usr/share/fonts/TTF" 
  done
  
  mkdir -p "${CACHE_PATH}/etc/fonts/conf.d" 
  install *.conf "${CACHE_PATH}/etc/fonts/conf.d" 
}
