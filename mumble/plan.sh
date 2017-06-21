pkg_origin=

pkg_name=mumble
pkg_version=1.2.86
_pkg_version=1.3.0~2318~g8f65051~snapshot
pkg_description="Open source, low-latency, high quality voice chat software"
pkg_upstream_url="http://mumble.sourceforge.net/"
pkg_license=('BSD')
pkg_deps=('speex' 'lsb-release' 'libxi' 'avahi' 'libsndfile' 'protobuf' 'pulseaudio' 'opus' 'qt5-svg') 
pkg_build_deps=('boost' 'mesa' 'qt5-tools')
#pkg_source=("https://github.com/mumble-voip/mumble/releases/download/$pkg_version/$pkg_name-$pkg_version.tar.gz")
pkg_source=("http://mumble.info/snapshot/${pkg_name}-${_pkg_version}.tar.gz"
        'setupview.diff')
pkg_shasum=('b44b9e0cdd433b64729c79c2c97f54fb'
         'ab49563b33a6d8fee7e9f32d856e9948')

do_build() {
  cd ${pkg_name}-${_pkg_version}
  #patch -p1 -i ${CACHE_PATH}/setupview.diff

  /usr/lib/qt5/bin/qmake main.pro \
    CONFIG+="bundled-celt no-bundled-opus no-bundled-speex no-speechd no-g15 no-xevie no-server \
    no-embed-qt-translations no-update packaged" \
    DEFINES+="PLUGIN_PATH=/usr/lib/mumble"
  make release
}

do_package() {
  cd ${pkg_name}-${_pkg_version}

  install -m755 -D ./release/mumble ${pkg_prefix}/usr/bin/mumble
  install -m755 -D ./scripts/mumble-overlay ${pkg_prefix}/usr/bin/mumble-overlay

  install -m755 -D ./release/libmumble.so.1.3.0 ${pkg_prefix}/usr/lib/mumble/libmumble.so.1.3.0
  ln -s libmumble.so.1.3.0 ${pkg_prefix}/usr/lib/mumble/libmumble.so
  ln -s libmumble.so.1.3.0 ${pkg_prefix}/usr/lib/mumble/libmumble.so.1
  ln -s libmumble.so.1.3.0 ${pkg_prefix}/usr/lib/mumble/libmumble.so.1.3
  install -m755 -D ./release/plugins/liblink.so ${pkg_prefix}/usr/lib/mumble/liblink.so
  install -m755 -D ./release/libcelt* ${pkg_prefix}/usr/lib/mumble/

  install -m644 -D ./scripts/mumble.desktop ${pkg_prefix}/usr/share/applications/mumble.desktop
  install -m755 -d ${pkg_prefix}/usr/share/man/man1
  install -m644 -D ./man/mum* ${pkg_prefix}/usr/share/man/man1/
  install -m644 -D ./icons/mumble.svg ${pkg_prefix}/usr/share/icons/hicolor/scalable/apps/mumble.svg
  install -m644 -D ./LICENSE $pkg_prefix/usr/share/licenses/${pkg_name}/LICENSE
}

