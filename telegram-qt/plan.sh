pkg_origin=

pkg_name=telegram-qt
pkg_version=0.1.0
_commit=3dd83d4c1d7d61a431bb94dbc3472beb9f18e928
pkg_description="Qt-based client library for Telegram IM"
pkg_upstream_url="https://github.com/KDE/telegram-qt"
pkg_license=('GPL')
pkg_deps=('qt5-base')
pkg_build_deps=('extra-cmake-modules' 'git')
#groups=('kde-telepathy')
pkg_source=("https://github.com/Kaffeine/telegram-qt/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('fcc498a8c2655ee0d9877b1784e76cec')

do_build() {  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DUSE_QT4=OFF 
    #-DENABLE_TESTAPP=TRUE
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
