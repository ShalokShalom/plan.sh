pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-speech
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="Qt tts (text to speech) module, speech recognition may be introduced"
pkg_upstream_url="http://code.qt.io/cgit/qt/qtspeech.git/?h=HEAD"
pkg_license=('GPL3' 'LGPL' 'FDL' 'custom')
pkg_deps=('qt5-base' 'speech-dispatcher' 'qt5-multimedia')
_pkgfqn="qtspeech-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`)

do_build() {
    mkdir build   
  
    /usr/lib/qt5/bin/qmake ../qtspeech.pro
    make -j1
}

do_package() {
  
  make INSTALL_ROOT=${CACHE_PATH} install
  
  install -Dm644 ../LICENSE.LGPLv3 ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.LGPLv3
}
