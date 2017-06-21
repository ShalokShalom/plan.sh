pkg_origin=

# check https://github.com/google/mozc/issues/327 for Qt5 build
pkg_name=fcitx-mozc
_bldtype=Release
_zipcode_rel=201703
_protobuf_rev=a428e42072765993ff674fda72863c9f1aa2d268
_gyp_rev=920ee58c3d3109dea3cd37d88054014891a93db7
_japanese_usage_dictionary_rev=e5b3425575734c323e1d947009dd74709437b684
_mozc_rev=280e38fe3d9db4df52f0713acf2ca65898cd697a
_fcitx_patchver=2.18.2612.102.1
pkg_description="Japanese Input Method Editor designed for multi-platform"
pkg_version=2.20.2673.102
pkg_upstream_url="https://github.com/google/mozc"
pkg_license=('custom')
pkg_deps=('qt5-base' 'fcitx' 'zinnia')
pkg_build_deps=('pkg-config' 'python2' 'curl' 'gtk2' 'mesa' 'ninja' 'git' 'clang')
pkg_source=("mozc::git+https://github.com/google/mozc.git#commit=${_mozc_rev}"
        "japanese_usage_dictionary::git+https://github.com/hiroyuki-komatsu/japanese-usage-dictionary.git#commit=${_japanese_usage_dictionary_rev}"
        "gyp::git+https://chromium.googlesource.com/external/gyp#commit=${_gyp_rev}"
        "protobuf::git+https://github.com/google/protobuf.git#commit=${_protobuf_rev}"
        "https://downloads.sourceforge.net/pnsft-aur/x-ken-all-${_zipcode_rel}.zip"
        "https://downloads.sourceforge.net/pnsft-aur/jigyosyo-${_zipcode_rel}.zip"
        "https://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${_fcitx_patchver}.patch"
        "https://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-icon.tar.gz")
pkg_shasum=('SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'fbe4b078719398ba8c3486cf0e799ee8'
         'be87dd5cff89b6bbb56e574812b237f8'
         'f364b7df92eb13a4e90aace81bfe4d11'
         '80fe2ef127b70649df22d133822ac8a7')

do_prepare() {
  cd mozc/src

  rm unix/fcitx -rf
  patch -p2 -i ${CACHE_PATH}/fcitx-mozc-${_fcitx_patchver}.patch

  # disable Japanese zip code in dictionary, python import fails to find dictionary
  #python2 dictionary/gen_zip_code_seed.py --zip_code="${CACHE_PATH}/x-ken-all.csv" --jigyosyo="${CACHE_PATH}/JIGYOSYO.CSV" >> data/dictionary_oss/dictionary09.txt

  cd ${CACHE_PATH}
  for dep in gyp protobuf japanese_usage_dictionary
  do
    cp -a $dep mozc/src/third_party/
  done
}

do_build() {
  cd mozc/src

  _targets="server/server.gyp:mozc_server gui/gui.gyp:mozc_tool unix/fcitx/fcitx.gyp:fcitx-mozc"

  QTDIR=/usr GYP_DEFINES="document_dir=/usr/share/licenses/$pkg_name use_libzinnia=1" python2 build_mozc.py gyp
  python2 build_mozc.py build -c $_bldtype $_targets

  head -n 29 server/mozc_server.cc > LICENSE
}

do_package() {
  cd mozc/src
  install -D -m 755 out_linux/${_bldtype}/mozc_server ${pkg_prefix}/usr/lib/mozc/mozc_server
  install    -m 755 out_linux/${_bldtype}/mozc_tool   ${pkg_prefix}/usr/lib/mozc/mozc_tool

  install -d ${pkg_prefix}/usr/share/licenses/$pkg_name/
  install -m 644 LICENSE data/installer/*.html ${pkg_prefix}/usr/share/licenses/${pkg_name}/

  for mofile in out_linux/${_bldtype}/gen/unix/fcitx/po/*.mo
  do
    filename=`basename $mofile`
    lang=${filename/.mo/}
    install -D -m 644 $mofile ${pkg_prefix}/usr/share/locale/$lang/LC_MESSAGES/fcitx-mozc.mo
  done

  install -D -m 755 out_linux/${_bldtype}/fcitx-mozc.so ${pkg_prefix}/usr/lib/fcitx/fcitx-mozc.so
  install -D -m 644 unix/fcitx/fcitx-mozc.conf ${pkg_prefix}/usr/share/fcitx/addon/fcitx-mozc.conf
  install -D -m 644 unix/fcitx/mozc.conf ${pkg_prefix}/usr/share/fcitx/inputmethod/mozc.conf

  install -d ${pkg_prefix}/usr/share/fcitx/mozc/icon
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-alpha_full.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-alpha_full.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-alpha_half.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-alpha_half.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-direct.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-direct.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-hiragana.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-hiragana.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-katakana_full.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-katakana_full.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-katakana_half.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-katakana_half.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-dictionary.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-dictionary.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-properties.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-properties.png
  install -m 644 $CACHE_PATH/fcitx-mozc-icons/mozc-tool.png ${pkg_prefix}/usr/share/fcitx/mozc/icon/mozc-tool.png
}

