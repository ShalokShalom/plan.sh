pkg_origin=

# colord GUI vs Oyranus GUI https://www.freedesktop.org/software/colord/faq.html#oyranos

pkg_name=colord-kde
pkg_version=0.5.0
_commit=2d1ed5973abe185d6063320052d00af40faec1f6
pkg_description="Daemon that manages color profiles, including a KCM that manages colord profiles"
pkg_upstream_url='https://dantti.wordpress.com/2012/03/12/coloring-you-desktop-with-colord-kde/'
pkg_license=('GPL')
pkg_deps=('colord' 'libxrandr' 'kconfigwidgets' 'kcoreaddons' 'kdbusaddons' 'ki18n'
         'kcmutils' 'kwidgetsaddons' 'kwindowsystem')
pkg_build_deps=('extra-cmake-modules')
#pkg_source=("http://download.kde.org/stable/colord-kde/$pkg_version/src/$pkg_name-$pkg_version.tar.xz")
pkg_source=("https://github.com/KDE/colord-kde/archive/${_commit}.zip")
pkg_shasum=('d6158b4c6647d1ef25dea1f3acca7ac1')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
