pkg_origin=cosmos

pkgbase=hyphen
pkg_name=('hyphen' 'hyphen-en')
pkg_version=2.8.8
pkg_upstream_url="http://hunspell.sf.net"
pkg_license=('GPL2' 'LGPL2' 'MPL')
pkg_build_deps=('glibc' 'perl')
pkg_source=("https://downloads.sourceforge.net/hunspell/${pkgbase}-${pkg_version}.tar.gz")
pkg_shasum=('5ade6ae2a99bc1e9e57031ca88d36dad')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

package_hyphen() {
 pkg_description="library for high quality hyphenation and justification"
 pkg_deps=('glibc' 'perl')

  make DESTDIR=${pkg_prefix}/ install-libLTLIBRARIES
  make DESTDIR=${pkg_prefix}/ install-binSCRIPTS
  make DESTDIR=${pkg_prefix}/ install-includeHEADERS
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkgbase}/LICENSE
}

package_hyphen-en() {
 pkg_description="English hyphenation rules"
 pkg_deps=('hyphen: offers hyphenation library functions')

  make DESTDIR=${pkg_prefix}/ install-hyphDATA

  pushd ${pkg_prefix}/usr/share/hyphen/
   en_US_aliases="en_AG en_AU en_BS en_BW en_BZ en_CA en_DK en_GB en_GH en_HK en_IE en_IN en_JM en_NA en_NZ en_PH en_SG en_TT en_ZA en_ZW"
   for lang in $en_US_aliases; do
        ln -s hyph_en_US.dic hyph_$lang.dic
   done
  popd
  
  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd ${pkg_prefix}/usr/share/myspell/dicts
    for file in ${pkg_prefix}/usr/share/hyphen/*; do
      ln -sv /usr/share/hyphen/$(basename ${file}) .
    done
  popd
}
