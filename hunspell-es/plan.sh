pkg_origin=cosmos

pkg_name=hunspell-es
pkg_version=2.2
pkg_description="Spanish hunspell dictionaries"
pkg_upstream_url="https://github.com/sbosio/rla-es"
pkg_license=('LGPL')
pkg_deps=('hunspell')
noextract=(es_ANY.oxt es_AR.oxt es_BO.oxt es_CL.oxt es_CO.oxt 
           es_CR.oxt es_CU.oxt es_DO.oxt es_EC.oxt es_ES.oxt 
           es_GT.oxt es_HN.oxt es_MX.oxt es_NI.oxt es_PA.oxt 
           es_PE.oxt es_PR.oxt es_PY.oxt es_SV.oxt es_UY.oxt es_VE.oxt)
pkg_source=("https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_ANY.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_AR.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_BO.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_CL.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_CO.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_CR.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_CU.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_DO.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_EC.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_ES.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_GT.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_HN.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_MX.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_NI.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_PA.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_PE.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_PR.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_PY.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_SV.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_UY.oxt"
        "https://github.com/sbosio/rla-es/releases/download/v${pkg_version}/es_VE.oxt")
pkg_shasum=('5d2a621da5e00871f5d43537b343a7c5'
         '9c2e0eb4124a4f8bcc1f90fbcc22a729'
         '2ff909220bf829bb08651ad1243f766f'
         '631ff1bd78a377077a84e91895db8554'
         'b8030f0e018b9a0b879916c2bc6b99cc'
         'bfb8b65dc58cfadb456247b3739a830b'
         '607df889fcd7f7f70cd31e5143a0ab22'
         '97ffa11e769f53f76f939dc1c5c45c6b'
         '7639d8d83c64d45b34f88b2cb30771ad'
         '8f6d52b55a41c1108234f625232131e4'
         '21291ce4ca017306321879706d6b8f52'
         'e7076ac541f547a314359d1795255ee6'
         '69919517517437a75603173d0fa9cb2c'
         'cd573e82a11eacccd1cb12cfa6e89797'
         'cd1a3ce9cf60621261b50c1cd975ba42'
         '5a8216aabea79171b7e2edaeb0077d6f'
         '7953ae81200fb978a0d44d11fcc6b7fd'
         '35795c6e097d2cff48774da834416988'
         '5a2b8f9a15542724a3ae12d7206af256'
         'baea8f23e87f509023461df40d1239b2'
         '9c71676888b8fab9f4dd7b8a88a44c68')

do_package() {

  for file in *.oxt; do
    LANG=en_US.utf8 bsdtar -xf $file
  done
  
  install -dm755 ${pkg_prefix}/usr/share/hunspell
  cp -p es_*.dic es_*.aff $pkg_prefix/usr/share/hunspell

  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd $pkg_prefix/usr/share/myspell/dicts
    for file in $pkg_prefix/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename $file) .
    done
  popd
  
  install -dm755 ${pkg_prefix}/usr/share/doc/$pkg_name
  cp -p README.txt $pkg_prefix/usr/share/doc/$pkg_name
}
