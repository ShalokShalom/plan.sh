pkg_origin=

pkgbase=krita-l10n
pkg_version=2.99.91
pkg_description="Language pack for Krita"
pkg_upstream_url="https://krita.org/"
pkg_license=('LGPL')
pkg_deps=('ki18n')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')

_languages=(
  'af     "Afrikaans"'
  'ar     "Arabic"'
  #'as     "Assamese"'
  #'ast    "Asturian"'
  'be     "Belarusian"'
  'bg     "Bulgarian"'
  #'bn     "Bengali"'
  #'bn_IN  "Bengali (India)"'
  'br     "Breton"'
  'bs     "Bosnian"'
  'ca     "Catalan"'
  'ca@valencia "Valencian (southern Catalan)"'
  #'crh    "Crimean Tatar"'
  'cs     "Czech"'
  #'csb    "Kashubian"'
  'cy     "Welsh"'
  'da     "Danish"'
  'de     "German"'
  'el     "Greek"'
  'en_GB  "English (United Kingdom)"'
  'eo     "Esperanto"'
  #'es-AR  "Spanish (Argentina)"'
  'es     "Spanish"'
  'et     "Estonian"'
  'eu     "Basque"'
  'fa     "Farsi (Persian)"'
  'fi     "Finnish"'
  'fr     "French"'
  'fy     "Frisian"'
  'ga     "Irish Gaelic"'
  #'gd     "Gaelic"'
  'gl     "Galician"'
  #'gu     "Gujarati"'
  #'ha     "Hausa"'
  'he     "Hebrew"'
  'hi     "Hindi"'
  'hne    "Chhattisgarhi"'
  'hr     "Croatian"'
  #'hsb    "Upper Sorbian"'
  'hu     "Hungarian"'
  #'hy     "Armenian"'
  'ia     "Interlingua"'
  #'id     "Indonesian"'
  'is     "Icelandic"'
  'it     "Italian"'
  'ja     "Japanese"'
  #'ka     "Georgian"'
  'kk     "Kazakh"'
  'km     "Khmer"'
  #'kn     "Kannada"'
  'ko     "Korean"'
  #'ku     "Kurdish"'
  #'lb     "Luxembourgish"'
  'lt     "Lithuanian"'
  'lv     "Latvian"'
  'mai    "Maithili"'
  'mk     "Macedonian"'
  #'ml     "Malayalam"'
  'mr     "Marathi"'
  'ms     "Malay"'
  'nb     "Norwegian Bokmal"'
  'nl     "Dutch"'
  'nn     "Norwegian"'
  #'nso    "Sesotho sa Leboa"'
  'oc     "Occitan"'
  #'or     "Oriya"'
  'pa     "Punjabi"'
  'pl     "Polish"'
  #'ps     "Pashto"'
  'pt_BR  "Brazilian Portuguese"'
  'pt     "Portuguese"'
  #'rm     "Romansh"'
  'ro     "Romanian"'
  'ru     "Russian"'
  'se     "Northern Sami"'
  'sk     "Slovak"'
  'sl     "Slovenian"'
  'sq     "Albanian"'
  #'sr     "Serbian"'
  'sv     "Swedish"'
  'ta     "Tamil (Sri Lanka)"'
  'tg     "Tajik"'
  'th     "Thai"'
  'tr     "Turkish"'
  'ug     "Uyghur"'
  'uk     "Ukrainian"'
  'uz     "Uzbek"'
  'uz@cyrillic "Uzbek (Cyrillic)"'
  'vi     "Vietnamese"'
  'wa     "Walloon"'
  'xh     "Xhosa"'
  'zh_CN  "Chinese (simplified)"'
  'zh_TW  "Chinese (traditional)"'
)

pkg_name=()
pkg_source=()

for _lang in "${_languages[@]}"; do
  _locale=${_lang%% *}
  _pkg_name=krita-l10n-${_locale,,}
  
  pkg_name+=($_pkg_name)
  source+=("http://download.kde.org/unstable/krita/${pkg_version}/${pkgbase}/${pkgbase}-$_locale-${pkg_version}.tar.xz")
  eval "package_$_pkg_name() {
    _package $_lang
  }"
done

pkg_shasum=('52d2b66af01e56242ad2d6ae2ba7af8c'
         '2bf170fca1f429aa7b8cd42af13eac64'
         '23d5a4d9db4c31f0bf4e8b46e9fac801'
         '9b9ed494731bbcf1ee94cdff487a6f30'
         'a53dce5c8f1061b11d0fc333110f4694'
         '91502bbd1413aca46fa8626e067a6b6f'
         '96dab37cc9173a354ca815ba1d73f6bb'
         'b7a417101deb104dd5b0b0cf3684a386'
         'b3f8c86432c546a7dd524b058fb2f35d'
         '0a6b5fd808732153a4effd02032f1d8d'
         'a61962cdc9713593078c5ec16f7d38ef'
         '6c7b01fcbebd6d0206c9806c4422b1e0'
         'a6f9bcb9d1aee32b840582eb91184ac6'
         'c8179e5b52751302dd5c5e5039461720'
         '86c168d876bedcec48af99d9f957acdb'
         '098831edcdaaf02418c6951aba06b132'
         '7dda0f38654ad05e98219b49673954b3'
         '4fb45c16ee499db20d53b617d3f51ee1'
         '45345a375bde15e7623a6c5568ce7dfe'
         'c85018684c81a762c11390a9fa9127da'
         'fc294973b9d3b8143a5d27ddad1d420e'
         'cd21e38d379b5498ab825e7836877300'
         'b371dfb98eaa0165b5455f797e1caff5'
         '3c4631061dc759c1a16a059f91f99f3a'
         'b0e70457f6eec3f9163503d276bafc32'
         '70272b26e1caaa65fcb9cf9191c94130'
         'accfdef07cb0e23780359c9e2099db23'
         '737751fb978e0bddc6126ceb43bc635d'
         '9a2e9ced2037c4e48d48ef6d8f9a60e9'
         'd27ddceeaf8a171ec229ac7d55f03f99'
         '8b9f740738386d35c3a71d70c7b2216a'
         '6260b2e93b49772b36443f2ef3314bd7'
         '62145fa9e430830d1a1d85c424d626ad'
         'cff53a6b73cae0926532e1a824c444f0'
         'f19fbf02cdc428a6b19aa85ea2b1e41c'
         '215b8f2dc62861f078e7bcbd01c9299c'
         '72be0775922306615a13366ab29fd956'
         '90962204b8d62a6ed143e2443ab255b4'
         '54cd236bd8bd2c383e8f1f3fe7f72e39'
         '831fb6b2e9b6818bfbbde81994792edd'
         '1246b89359c01e5bb60258023ec42989'
         '1fdc2eff0b3f55110236b24702813bc9'
         'a2c0b94979db8d3120a367b76f1e58d1'
         'c583f2d0001f4d65a9327b00443525c2'
         'd065d3425566a5524740307d1fb2a23f'
         'ce8c4d879ab17889e2afb6ddd60b13f3'
         '03e1313f7352bd833139d3afab512c7c'
         'c1e493b6016c35a806cddd1e30b241a5'
         'bd18f05a522c720fe3b5558126c63fdc'
         '79ec4cd9849cd6bb5bd472720f193819'
         '65cd0f2feb9f215664c78f2358455464'
         '627aab267ba51df69498f0e7add1929b'
         '779716846050e0acf1ce235b1612c46b'
         '27d793961416b4559aa7cc0315f43d05'
         'eab60a104aff4e1edb7a4061ddf68ac0'
         '4070b34af077066d83fac12dd0ed833a'
         'c2693f8de519233891cbc9acd5a03121'
         '0421e9c6a9ed2f0e026854463c4f15c6'
         '2cd6c024e113b6d9f0e17388e7c06cd1'
         'd9947caa946103e0eaaf02331f6335df'
         '9ecc61e594543acbbfc71e314e9bd67a'
         '2b680e5680926b4f4cad8b90749245dd'
         '99dfa3eade1297ff9cd9a57f42f0035f'
         '29adcf2ba17a429e5710eaaa852c44fb'
         'f9cebb4dd5f4be7f8f611b112535f4bb'
         '8f6a4c1479b0a80a1f8aefe48188c005'
         '99909d69e8594cfcd039e545b9b6fa40'
         '7ff031b9408a0a54d27f75e563959345'
         '7e75e509f7fcc7edcc9c50468ec566f1'
         '258d08718e0983209e79c5a03265b6d8')
do_build() {
  for _lang in "${_languages[@]}"; do
    _locale=${_lang%% *}
    
    mkdir -p build/${_locale}
    cd build/${_locale}
      cmake ${CACHE_PATH}/krita-l10n-${_locale}-${pkg_version} \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr
    make 
    cd ../..
  done
}

_do_package() {
  pkg_description="$2 language pack for Krita"
  groups=('localization' 'krita-l10n')
  
  cd build/$1
  make DESTDIR="$pkg_prefix" install
}
