pkg_origin=cosmos

pkg_name=hunspell-pt-br
pkg_version=3.2
pkg_description="Portuguese (Brazil) dictionary."
pkg_upstream_url="http://www.broffice.org/verortografico/"
pkg_license=('LGPL-2.1')
pkg_deps=('hunspell')
pkg_source=('http://pt-br.libreoffice.org/assets/Uploads/PT-BR-Documents/VERO/VeroptBRV320AOC.oxt')
pkg_shasum=('9a9ac174c401406604bfcf101de2a7ba')

do_package() {

  install -D -m644 pt_BR.dic "${pkg_prefix}/usr/share/hunspell/pt_BR.dic"
  install -D -m644 pt_BR.aff "${pkg_prefix}/usr/share/hunspell/pt_BR.aff"

  install -d -m755 "${pkg_prefix}/usr/share/myspell/dicts"
  ln -s /usr/share/hunspell/pt_BR.dic ${pkg_prefix}/usr/share/myspell/dicts/pt_BR.dic
  ln -s /usr/share/hunspell/pt_BR.aff ${pkg_prefix}/usr/share/myspell/dicts/pt_BR.aff
}

