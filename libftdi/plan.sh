pkg_origin=cosmos

pkg_name=libftdi
pkg_version=1.3
pkg_description="Open source library to talk to FTDI chips including the popular bitbang mode."
pkg_upstream_url="http://www.intra2net.com/en/developer/libftdi/download.php"
pkg_license=("GPL2")
pkg_deps=('libusb' 'gcc-libs' 'python3')
pkg_build_deps=('boost' 'cmake' 'swig')
pkg_source=("http://www.intra2net.com/en/developer/libftdi/download/${pkg_name}1-${pkg_version}.tar.bz2")
pkg_shasum=('156cdf40cece9f8a3ce1582db59a502a')

do_build() {
  sed -i 's|LIB_SUFFIX 64|LIB_SUFFIX ""|' CMakeLists.txt
  
  mkdir build
  cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
           -DCMAKE_SKIP_BUILD_RPATH=ON \
           -DCMAKE_BUILD_TYPE=Release \
           -DEXAMPLES=OFF \
           -DFTDI_EEPROM=OFF
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
