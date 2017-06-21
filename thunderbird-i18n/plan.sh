pkg_origin=

pkgbase=thunderbird-i18n
pkg_version=52.2.0
pkg_description="Language pack for Thunderbird"
pkg_upstream_url="http://www.mozilla.com/"
pkg_license=('MPL' 'GPL')
pkg_deps=("thunderbird=${pkg_version}")

_languages=(
  'ar     "Arabic"'
  'ast    "Asturian"'
  'be     "Belarusian"'
  'bg     "Bulgarian"'
  'bn-BD  "Bengali (Bangladesh)"'
  'br     "Breton"'
  'ca     "Catalan"'
  'cs     "Czech"'
  'da     "Danish"'
  'de     "German"'
  'el     "Greek"'
  'en-GB  "English (United Kingdom)"'
  'en-US  "English (United States)"'
  'es-AR  "Spanish (Argentina)"'
  'es-ES  "Spanish (Spain)"'
  'et     "Estonian"'
  'eu     "Basque"'
  'fi     "Finnish"'
  'fr     "French"'
  'fy-NL  "Frisian (Netherlands)"'
  'ga-IE  "Irish"'
  'gd     "Gaelic"'
  'gl     "Galician"'
  'he     "Hebrew"'
  'hr     "Croatian"'
  'hu     "Hungarian"'
  'hy-AM  "Armenian"'
  'id     "Indonesian"'
  'is     "Icelandic"'
  'it     "Italian"'
  'ja     "Japanese"'
  'ko     "Korean"'
  'lt     "Lithuanian"'
  'nb-NO  "Norwegian (Bokmal)"'
  'nl     "Dutch"'
  'nn-NO  "Norwegian (Nynorsk)"'
  'pa-IN  "Punjabi"'
  'pl     "Polish"'
  'pt-BR  "Brazilian Portuguese"'
  'pt-PT  "Portuguese"'
  'rm     "Romansh"'
  'ro     "Romanian"'
  'ru     "Russian"'
  'si     "Sinhalese"'
  'sk     "Slovak"'
  'sl     "Slovenian"'
  'sq     "Albanian"'
  'sr     "Serbian"'
  'sv-SE  "Swedish"'
  'ta-LK  "Tamil (Sri Lanka)"'
  'tr     "Turkish"'
  'uk     "Ukrainian"'
  'vi     "Vietnamese"'
  'zh-CN  "Chinese (simplified)"'
  'zh-TW  "Chinese (traditional)"'
)

pkg_name=()
pkg_source=()
pkg_shasum=('4ec51a7da7dc7763149ab32f509a7b63'
         '4f32535e86ed9032228a355a21129c24'
         '7b0c046831f13795b33e174aff34727f'
         '5ef21d184961e5b2bbc208802c3d1f13'
         'e9de2da21aea36382c73a4244df39a8b'
         '5f2d45c690e8db9e400ab7ceccff742a'
         'c89982bb97eefa35ed2f2df3197a2d0e'
         '08c5031241b7b47649f98ca478b5dddf'
         '56f7ad0ed1622bf0037b2a418fac9c8c'
         'd08602fbf8c5bf0310d739c48c876867'
         '2db145ed523b7b2079ca6e50d3d24d37'
         'ce7f99d2cd842d67bce23a61a4f0fed4'
         '47bd0962b288489d308e54f78affe0cc'
         'dcb2349c6e5dbb7dacbc3d05336abbe3'
         '15b1b17c411a3b4f048d87f56e07c11a'
         '90250a13963cc0a9007358869167b3a4'
         'b48dbb2afa24ed3da3b43bdde2b45157'
         'a604e879a563eeaf2cda79914ec30792'
         '905826b265b718c7e10bfd7b06afd78c'
         '63a4d8f8bf234282b27a981351d1d34c'
         '9f976da7c98d3695e9dd2984f73cd4b2'
         'cd3f163c30e62a497a87c2db4a46259a'
         '4b1954f93bcd68bb3c61bc63c0b78022'
         'bf8f541e5e853dcc10c14ada4383592d'
         '28606209af16fb3ae5cab654c8188c57'
         'cfb4996be12b0cde06e913d40f1b6cd0'
         '60a3b714595a6b4a36d4e928a5124809'
         '5f408bca9c9dd632433980e63dc78b83'
         '6582ad02f0a465db749a360fa0c206d4'
         '9b294b545828158a83dd2ff547671587'
         'd6527fd1bfff8b032d35da54af017476'
         '854943c600e08a09cb4c62905da06c3a'
         '3c7c45e10820af99e033680fa65d72ef'
         '6b10a95857d1758d8ce34c275dc18e0b'
         '71afc1dd228fa23a41acf936754b5652'
         '4e76feb0cb8dcfe5a69825c20717d4ea'
         '8155f7d3913cdac27c9634b24e531488'
         '7960fd0ffeed7dbe0a0c4b0cc69a2683'
         'f4c286ac59e0b2034f937a9d5089484d'
         '4f6fb2aee3b54762b68c29b2766b84f0'
         '0d2bcba5015dab3a224c47b7e142f9d9'
         '49155ab4edc6f991be40c87a621429c4'
         '79dd45d6dfa17440917d5cef217acba9'
         '22bf81b90c518fffafc53cde6153e412'
         'a3f7263591b24125fabe0e35caa72a33'
         '4fdc044babde75572260c692abcff33c'
         '5545219d868d943180c36b9509c9b617'
         'ca125a6a58cc56886c8c2818581affb5'
         '02d91cd92304d87853dda5bc4fe704d8'
         'dc71549fe290e8f6c73bf53f83da4385'
         '00bebfa073ef1743bba01e7c5f9eca35'
         'ab3168c19a59c4599665bdc9f7217322'
         'b7e79919152ef2ddeb128397b0f3dee8'
         '2247318d17743f41b7176c0233429a39'
         'ff8dd4f2a7765ef836d8de0ed748a72a')
_pkg_upstream_url=https://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/$pkg_version/linux-i686/xpi

for _lang in "${_languages[@]}"; do
  _locale=${_lang%% *}
  _pkg_name=thunderbird-i18n-${_locale,,}

  pkg_name+=($_pkg_name)
  source+=("thunderbird-i18n-$pkg_version-$_locale.xpi::$_url/$_locale.xpi")
  eval "package_$_pkg_name() {
    _package $_lang
  }"
done

noextract=(${source[@]%%::*})

_do_package() {
  pkg_description="$2 language pack for Thunderbird"
  install -Dm644 thunderbird-i18n-${pkg_version}-$1.xpi \
    ${pkg_prefix}/opt/thunderbird-${pkg_version}/extensions/langpack-$1@thunderbird.mozilla.org.xpi
}
