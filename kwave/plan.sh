pkg_origin=


# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kwave
pkg_version=${_kdever}
pkg_description="Sound editor designed for the Plasma Desktop Environment"
pkg_upstream_url="http://kwave.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('kcompletion' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'kdbusaddons' 
         'ki18n' 'kiconthemes' 'kio' 'ktextwidgets' 'kxmlgui' 'kwidgetsaddons'
         'pulseaudio' 'audiofile' 'flac' 'fftw' 'libvorbis' 'libsamplerate' 'opus'
         'qt5-multimedia') # for mp3 support: 'libmad' 'id3lib'
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`) 

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=/usr/lib \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DWITH_MP3=OFF  # id3lib not in repo, upstream works on taglib
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
}
