pkg_origin=

pkg_name=telepathy-morse
pkg_version=0.1.0
_commit=8e701b53fd9d54df8388dd22127f736e7b5a7a43
pkg_description="Telegram connection manager for Telepathy."
pkg_upstream_url="https://github.com/KDE/telepathy-morse"
pkg_license=('GPL')
pkg_deps=('telegram-qt' 'telepathy-qt5')
pkg_build_deps=('extra-cmake-modules' 'git')
#groups=('kde-telepathy')
pkg_source=("https://github.com/TelepathyQt/telepathy-morse/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('3e3250e6fca470546bb26eff76ff6d10')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_LIBEXECDIR=lib/telepathy 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
