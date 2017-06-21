pkg_origin=
pkg_name=otter-browser
pkg_version=0.9.12.4
_commit=f6b03a68b1f1cfdd97f19f95ea3a4fb21733d8d5
pkg_description='Browser aiming to recreate the best aspects of the classic Opera (12.x) UI using Qt5.'
pkg_upstream_url="http://www.otter-browser.org"
pkg_license=('GPL3')
pkg_deps=('qtwebkit-tp' 'qt5-multimedia' 'desktop-file-utils' 'hicolor-icon-theme' 'hunspell') 
pkg_build_deps=('cmake' 'qt5-tools')
pkg_source=("https://github.com/OtterBrowser/otter-browser/archive/${_commit}.tar.gz")
pkg_shasum=('cf9af038a2f967c0fc1c00d0305d4f62')

do_prepare() {
  cd ${pkg_name}-${_commit}
  
  #sed -i -e 's|hunspell-1.3|hunspell-1.6|' cmake/FindHunspell.cmake
}

do_build() {
  cd ${pkg_name}-${_commit}
  /usr/lib/qt5/bin/lrelease resources/translations/*.ts

  mkdir -p build
  cd build
  
  cmake ../ \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DENABLE_QTWEBENGINE=OFF \
    -DENABLE_QTWEBKIT=ON 
  make
}

do_package() {
  cd ${pkg_name}-${_commit}/build
  make DESTDIR=${pkg_prefix} install
  
  install -D -m0644 ../../${pkg_name}-${_commit}/COPYING  ${pkg_prefix}/usr/share/licenses/otter-browser/COPYING
}

