pkg_origin=cosmos

pkg_name=ttf-liberation
pkg_version=2.00.1
pkg_description="Font family which aims at metric compatibility with Arial, Times New Roman, and Courier New, sponsored by Red Hat"
pkg_license=('custom' 'GPL2')
pkg_upstream_url="https://pagure.io/liberation-fonts/"
pkg_deps=('fontconfig' 'xorg-fonts-encodings' 'xorg-font-utils')
pkg_build_deps=('fontforge' 'python2-fonttools')
install=${pkg_name}.install
pkg_source=("https://releases.pagure.org/liberation-fonts/liberation-fonts-${pkg_version}.tar.gz"
        '30-0-liberation-mono.conf'
        '30-0-liberation-sans.conf'
        '30-0-liberation-serif.conf')
pkg_shasum=('a0dfdcffcd0398afe5f57269198846e9'
         '23ce227d5d72c6df2c69caf367d96341'
         '88e91e718053d46cb1215067ffb0024a'
         '5bc229f0f7ad387f1ba311148fcbff00')

do_build() {
  
  make 
}
do_package() {

  install -d ${CACHE_PATH}/usr/share/fonts/TTF/
  install -m644 *.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
  
  install -Dm0644 ${CACHE_PATH}/30-0-liberation-mono.conf ${CACHE_PATH}/etc/fonts/conf.avail/30-${pkg_name}-mono.conf
  install -Dm0644 ${CACHE_PATH}/30-0-liberation-sans.conf ${CACHE_PATH}/etc/fonts/conf.avail/30-${pkg_name}-sans.conf
  install -Dm0644 ${CACHE_PATH}/30-0-liberation-serif.conf ${CACHE_PATH}/etc/fonts/conf.avail/30-${pkg_name}-serif.conf

  install -Dm0644 ../LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

