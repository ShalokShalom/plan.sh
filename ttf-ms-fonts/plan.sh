pkg_origin=cosmos

pkg_name=ttf-ms-fonts
pkg_version=2.0
pkg_description="Core TTF Fonts from Microsoft"
pkg_upstream_url="http://corefonts.sourceforge.net/"
pkg_license=('custom:microsoft')
pkg_deps=('xorg-fonts-encodings' 'xorg-font-utils' 'fontconfig')
pkg_build_deps=('libarchive')
install=${pkg_name}.install
pkg_source=("https://downloads.sourceforge.net/corefonts/andale32.exe" 
        "https://downloads.sourceforge.net/corefonts/arial32.exe" 
        "https://downloads.sourceforge.net/corefonts/arialb32.exe"
        "https://downloads.sourceforge.net/corefonts/comic32.exe" 
        "https://downloads.sourceforge.net/corefonts/courie32.exe" 
        "https://downloads.sourceforge.net/corefonts/georgi32.exe"
        "https://downloads.sourceforge.net/corefonts/impact32.exe" 
        "https://downloads.sourceforge.net/corefonts/times32.exe"
        "https://downloads.sourceforge.net/corefonts/trebuc32.exe"
        "https://downloads.sourceforge.net/corefonts/verdan32.exe" 
        "https://downloads.sourceforge.net/corefonts/webdin32.exe")
pkg_shasum=('cbdc2fdd7d2ed0832795e86a8b9ee19a'
         '9637df0e91703179f0723ec095a36cb5'
         'c9089ae0c3b3d0d8c4b0a95979bb9ff0'
         '2b30de40bb5e803a0452c7715fc835d1'
         '4e412c772294403ab62fb2d247d85c60'
         '4d90016026e2da447593b41a8d8fa8bd'
         '7907c7dd6684e9bade91cff82683d9d7'
         'ed39c8ef91b9fb80f76f702568291bd5'
         '0d7ea16cac6261f8513a061fbfcdb2b5'
         '12d2a75f8156e10607be1eaa8e8ef120'
         '230a1d13a365b22815f502eb24d9149b')

do_package() { 
  install -dm755 ${CACHE_PATH}/usr/share/fonts/TTF

  for font in *.{ttf,TTF}; do
    install -m644 ${font} ${CACHE_PATH}/usr/share/fonts/TTF/$(echo ${font}|tr A-Z a-z)
  done

  install -Dm644 Licen.TXT ${CACHE_PATH}/usr/share/licenses/$pkg_name/LICENSE
}

