pkg_origin=

pkg_name=opencpn
pkg_version=4.4.0
_pkg_version=4.1.1329
pkg_description="Open Source Chart Plotting / Marine Navigation"
pkg_upstream_url="http://opencpn.org"
pkg_license=("GPL2")
pkg_deps=('wxgtk2.9' 'gpsd' 'portaudio' 'tinyxml' 'hicolor-icon-theme')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/OpenCPN/OpenCPN/archive/v${pkg_version}.tar.gz")
pkg_shasum=('d991b49373c45f9756fa79c3b3a0f215')
 
do_build() {
  cd OpenCPN-${pkg_version}
  
  cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  cd OpenCPN-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}

