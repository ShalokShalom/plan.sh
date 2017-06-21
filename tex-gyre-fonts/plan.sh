pkg_origin=cosmos

pkg_name=tex-gyre-fonts
pkg_version=2.005
pkg_description="Extensive remake and extension of the freely available 35 base PostScript fonts"
pkg_upstream_url="http://www.gust.org.pl/projects/e-foundry/tex-gyre"
pkg_license=('custom')
pkg_deps=('fontconfig')
install=tex-gyre-fonts.install
pkg_source=("http://www.gust.org.pl/projects/e-foundry/tex-gyre/whole/tg-${pkg_version}otf.zip"
        "http://www.gust.org.pl/projects/e-foundry/licenses/GUST-FONT-LICENSE.txt")
pkg_shasum=('3774af603b5a13d374bf4668967bff57'
         '7ab98aedba83bca3de4a3ca3792e7390')

do_package() {
  install -d ${CACHE_PATH}/usr/share/fonts/tex-gyre
  install -m0644 *.otf ${CACHE_PATH}/usr/share/fonts/tex-gyre/
  
  install -Dm644 GUST-FONT-LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
