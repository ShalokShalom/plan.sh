pkg_origin=

pkg_name=dianara
pkg_version=1.3.7
pkg_description="A Qt pump.io client"
pkg_upstream_url="http://dianara.nongnu.org/"
pkg_license=('GPL')
pkg_deps=('qjson' 'qoauth' 'qca-qt5')
pkg_source=("http://download-mirror.savannah.gnu.org/releases/dianara/${pkg_name}-v${pkg_version}.tar.gz")
pkg_shasum=('674ac308952e152771a58ac3a19e106e')

do_build() {
  cd ${pkg_name}-v${pkg_version}
  mkdir -p build 
  
  cd build
  /usr/lib/qt5/bin/qmake ..
  sed -i 's|include5|include|' Makefile
  make
}

do_package() {
  cd ${pkg_name}-v${pkg_version}/build
  
  make INSTALL_ROOT=${pkg_prefix} install
}

