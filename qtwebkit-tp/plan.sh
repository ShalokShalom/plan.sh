pkg_origin=cosmos

pkg_name=qtwebkit-tp
pkg_version=5.212.0.1
_pkg_version=5.212.0-alpha2
#_commit=8bed62ae51870074d3bc8f48791b19911bfc4d10
pkg_description='Cross-platform application and UI framework, QtWebkit files (revived branch)'
pkg_upstream_url='https://github.com/annulen/webkit'
pkg_license=('LGPLv2')
pkg_deps=('qt5-sensors' 'qt5-location' 'icu' 'libxslt' 'libxcomposite' 
         'gst-plugins-base' 'gst-plugins-good' 'libwebp' 'mesa' 'qt5-serialport' 'qt5-webchannel'
         'qt5-imageformats' 'gst-libav' 'gst-plugins-bad' 'hyphen')  
pkg_build_deps=('gperf' 'sqlite' 'fontconfig' 'perl' 'python2' 'ruby' 'extra-cmake-modules' 'qt5-tools')
groups=('qt5')
#pkg_source=("https://github.com/annulen/qtwebkit-snapshots/archive/${_commit}.zip"
pkg_source=("https://github.com/annulen/webkit/archive/qtwebkit-${_pkg_version}.tar.gz"
        "https://raw.githubusercontent.com/Alexpux/MINGW-packages/master/mingw-w64-qtwebkit/0012-install-additional-pri-files.patch")
pkg_shasum=('b2e0445d0f7d5f50a235de7fd45ec053'
         'd3997143a1b57cbbfbd4364713fea91d')

do_prepare() {

  patch -p1 -i $CACHE_PATH/0012-install-additional-pri-files.patch
}

do_build() {
  mkdir -p build
  
  cmake ../webkit-qtwebkit-${_pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_INCLUDEDIR=/usr/include/qt5 \
    -DPORT=Qt \
    -DUSE_QT_MULTIMEDIA=OFF \
    -DENABLE_OPENGL=ON
  make
}

do_package() {
   
   make DESTDIR=${CACHE_PATH} install
}
