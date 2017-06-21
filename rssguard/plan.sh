pkg_origin=

pkg_name=rssguard
pkg_version=3.4.0
pkg_description="Simple (yet powerful) feed reader, able to fetch the most known feed formats, including RSS/RDF and ATOM."
pkg_upstream_url="https://github.com/martinrotter/rssguard"
pkg_license=('GPL')
pkg_deps=('qtwebengine')
pkg_build_deps=('qt5-tools')
pkg_source=("https://github.com/martinrotter/rssguard/archive/${pkg_version}.tar.gz")
pkg_shasum=('32cf2d946d54ba0d6be413b210ecdb4c')

do_build() {
  mkdir -p build
  cd build

  /usr/lib/qt5/bin/qmake ../${pkg_name}-${pkg_version}/rssguard.pro -r \
    CONFIG+=release PREFIX=/usr \
    INSTALL_ROOT=${pkg_prefix}/ \
    LRELEASE_EXECUTABLE=/usr/lib/qt5/bin/lrelease
  make
}

do_package() {
  cd build

  make INSTALL_ROOT=${pkg_prefix}/ install
}
