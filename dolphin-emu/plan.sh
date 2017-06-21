pkg_origin=

pkg_name=dolphin-emu
pkg_version=5.0
_commit=dbd67c6
pkg_description='GameCube, Wii and Triforce emulator'
pkg_upstream_url='http://dolphin-emu.org'
pkg_license=('GPL2')
pkg_deps=('bluez' 'ffmpeg' 'glew' 'libao' 'miniupnpc' 'openal' 'portaudio'
         'sdl2' 'soundtouch' 'qt5-base' 'pulseaudio' 'gtk2' 'glu')
pkg_build_deps=('cmake' 'opencl-headers')
#pkg_source=("https://github.com/dolphin-emu/dolphin/tarball/master/${pkg_name}-${pkg_version}.tar.gz")
pkg_source=("https://github.com/dolphin-emu/dolphin/archive/${pkg_version}.tar.gz")
pkg_shasum=('ed94272956adbec690808f6e4d8ff065')
         
do_build() {
  cd dolphin-${pkg_version}

  mkdir build 
  cd build
  cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
           -DCMAKE_CXX_FLAGS='-fno-inline-functions -fpermissive' \
           -DENABLE_LTO=ON \
           -DENABLE_QT2=ON
           #-DDISABLE_WX=ON 
  make
}

do_package() {
  cd dolphin-${pkg_version}/build

  make DESTDIR=${pkg_prefix} install
  
  #install -m 755 Binaries/dolphin-emu-qt2 ${pkg_prefix}/usr/bin/
  #sed -i -e 's|Exec=dolphin-emu|Exec=dolphin-emu-qt|' ${pkg_prefix}/usr/share/applications/dolphin-emu.desktop
}


