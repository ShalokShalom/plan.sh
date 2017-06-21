pkg_origin=

pkg_name=sigil
_pkg_name=Sigil
_commit=adef8f662a1cd85675bed7f45b156baaf20c85e2
pkg_version=0.9.8
pkg_description="A multi-platform WYSIWYG ebook editor. It is designed to edit books in ePub format. "
pkg_upstream_url="https://github.com/user-none/Sigil"
pkg_license=('GPL3')
pkg_deps=('qtwebkit-tp' 'qt5-svg' 'qt5-webchannel' 'boost-libs' 'xerces-c' 'python3-lxml'
         'python3-pillow' 'python3-six' 'pyqt5-python3' 'hunspell')
pkg_build_deps=('cmake' 'boost' 'qt5-tools' 'clang')
#options=('debug')
pkg_source=("https://github.com/user-none/Sigil/archive/${pkg_version}.tar.gz")
#pkg_source=("https://github.com/Sigil-Ebook/Sigil/archive/${_commit}.zip")
pkg_shasum=('bd36d282c724d41c4d2910135df18dc0')

do_prepare() {
  cd ${_pkg_name}-${pkg_version}

  # 0.9.8 tar misses correct version commit
  sed -i -e 's|SIGIL_REVISION_VERSION 7|SIGIL_REVISION_VERSION 8|' CMakeLists.txt
}

do_build() {
  cd ${_pkg_name}-${pkg_version}
  mkdir -p build 
  cd build
  
  export CC=/usr/bin/clang
  export CXX=/usr/bin/clang++

  cmake -G "Unix Makefiles" \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_SYSTEM_LIBS=1 \
    -DCMAKE_SKIP_RPATH=ON ..
  make 
}

do_package() {
  cd ${_pkg_name}-${pkg_version}/build
  make install DESTDIR=$pkg_prefix

  # Desktop integration.
  #for _pic in 16 32 48 128 256; do
  #  install -Dm0644 ../src/Sigil/Resource_Files/icon/app_icon_$_pic.png \
  #    $pkg_prefix/usr/share/icons/hicolor/$_picx$_pic/apps/$pkg_name.png
  #done
  # install -Dm644 ../src/Sigil/Resource_Files/icon/app_icon_128.png \
  #     $pkg_prefix/usr/share/pixmaps/$pkg_name.png
}
