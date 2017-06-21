pkg_origin=cosmos

pkgbase=ttf-noto
pkg_name=('noto-fonts' 'noto-fonts-otf')
# version based on latest adjusted font in Noto-hinted.zip
pkg_version=20170403
pkg_license=('SIL Open Font License (OFL)')
pkg_upstream_url="https://www.google.com/get/noto/"
pkg_source=("https://noto-website.storage.googleapis.com/pkgs/Noto-hinted.zip")
pkg_shasum=('59ba4db1e832db3c241db1cb224a0087')

package_noto-fonts-otf() {
  pkg_description="Google developed font family which aims to support all languages with a harmonious look and feel, OTF fonts "
  pkg_deps=('fontconfig' 'xorg-fonts-encodings' 'xorg-font-utils')
  install=noto-fonts-otf.install
    
  install -d $CACHE_PATH/usr/share/fonts/OTF
  install -m0644 *.otf ${CACHE_PATH}/usr/share/fonts/OTF/
    
  install -Dm644 LICENSE_OFL.txt $CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE
}

package_noto-fonts() {
  pkg_description="Google developed font family which aims to support all languages with a harmonious look and feel. "
  pkg_deps=('fontconfig' 'xorg-fonts-encodings' 'xorg-font-utils')
  install=noto-fonts.install
  
  install -d ${CACHE_PATH}/usr/share/fonts/TTF
  install -m0644 *.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
  
  install -Dm644 LICENSE_OFL.txt $CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE
}
