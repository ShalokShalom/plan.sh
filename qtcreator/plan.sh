pkg_origin=

pkg_name=qtcreator
pkg_version=4.3.0
_pkg_version=4.3
__pkg_version=4.3.0
pkg_description="Lightweight, cross-platform integrated development environment."
pkg_upstream_url="http://qt.digia.com/"
pkg_license=('LGPL')
pkg_deps=('qt5-tools' 'qt5-quickcontrols' 'qt5-script' 'qtwebengine' 'clang')
pkg_build_deps=('git')
optpkg_deps=('qt5-docs: for the integrated Qt documentation'
            'gdb: for the debugger'
            'cmake: for cmake project suppport'
            'git: for git support'
            'mercurial: for mercurial support'
            'bzr: for bazaar support')
pkg_source=("http://download.qt-project.org/official_releases/${pkg_name}/${_pkg_version}/${__pkg_version}/qt-creator-opensource-src-${__pkg_version}.tar.xz"
        'qtcreator.desktop')
pkg_shasum=('b8059b45c8b02a8d52d2d2e46b7b740b'
         '5162b73dd63f457bdb02bd9c8b1cc66b')

do_prepare() {
  cd qt-creator-opensource-src-${__pkg_version}

  sed -i 's|$$IDE_OUTPUT_PATH/libexec/qtcreator|$$IDE_OUTPUT_PATH/lib/qtcreator|' qtcreator.pri
  sed -i 's|$$QTC_PREFIX/libexec/qtcreator|$$QTC_PREFIX/lib/qtcreator|' qtcreator.pri
}         

do_build() {
  mkdir -p build
  cd build

  /usr/lib/qt5/bin/qmake ${CACHE_PATH}/qt-creator-opensource-src-${__pkg_version}/qtcreator.pro
  make 
  make docs -j1
}

do_package() {
  cd build

  make INSTALL_ROOT=${pkg_prefix}/usr install
  make INSTALL_ROOT=${pkg_prefix}/usr/ install_docs

  install -Dm644 ${CACHE_PATH}/qtcreator.desktop \
    ${pkg_prefix}/usr/share/applications/qtcreator.desktop
  install -Dm644 ${CACHE_PATH}/qt-creator-opensource-src-${__pkg_version}/LICENSE.GPL3-EXCEPT \
    ${pkg_prefix}/usr/share/licenses/qtcreator/LICENSE.GPL3-EXCEPT
}
