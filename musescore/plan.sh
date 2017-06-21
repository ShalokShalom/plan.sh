pkg_origin=

pkg_name=musescore
pkg_version=2.1.0
pkg_description="Music notation and composition software written in Qt"
pkg_upstream_url="https://www.musescore.org/en/"
pkg_license=('GPL')
pkg_deps=('qtwebkit-tp' 'qt5-svg' 'qt5-tools' 'openssl' 'pulseaudio' 'lame' 'portaudio' 'jack')
pkg_build_deps=('cmake' 'doxygen' 'texlive-core')
pkg_source=("https://github.com/musescore/MuseScore/archive/v${pkg_version}.tar.gz")
pkg_shasum=('de1bf9c231d35847191bf7321f527cd4')

do_prepare() {
  cd MuseScore-${pkg_version}
  #sed -i 's|add_subdirectory(manual)|#add_subdirectory(manual)|' CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../MuseScore-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_SKIP_RPATH=On
  make lrelease
  make manpages
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  # package mscore fonts so they can be used by other apps
  cd ../MuseScore-${pkg_version}
  install -m755 -d ${pkg_prefix}/usr/share/fonts/mscore
  install -m644 fonts/mscoreTab.*tf ${pkg_prefix}/usr/share/fonts/mscore/
  install -m644 fonts/MuseJazz.ttf ${pkg_prefix}/usr/share/fonts/mscore/
  install -m644 fonts/mscore/mscore.otf ${pkg_prefix}/usr/share/fonts/mscore/
  install -m644 fonts/mscore/*.ttf ${pkg_prefix}/usr/share/fonts/mscore/
}
