pkg_origin=

pkg_name=lmms
pkg_version=1.1.95
_pkg_version=1.2.0-rc2
_commit=3157dbf9931e2bb85e5aa9b2e20e27d9872be7e2
pkg_description='The Linux MultiMedia Studio.'
pkg_upstream_url='https://lmms.io/'
pkg_license=('GPL')
pkg_deps=('sdl' 'glib2' 'fluidsynth' 'libpng' 'libvorbis' 'libxft' 'libxinerama' 'qt5-base'
         'sdl_sound' 'libsamplerate' 'shared-mime-info' 'fltk' 'portaudio')
pkg_build_deps=('cmake' 'ladspa' 'libxft' 'freetype2' 'fftw' 'qt5-tools')
pkg_source=("https://github.com/LMMS/lmms/archive/v${_pkg_version}.tar.gz")
#pkg_source=("https://github.com/LMMS/lmms/archive/3157dbf9931e2bb85e5aa9b2e20e27d9872be7e2.zip")
pkg_shasum=('b52bb576b421e31102b6536f1b551635')

do_build() {
  cd lmms-${_pkg_version}/

  cmake . -DCMAKE_INSTALL_PREFIX=/usr \
          -DWANT_QT5=ON  
  make
}

do_package() {
  cd lmms-${_pkg_version}/
  
  make DESTDIR=${pkg_prefix} install
}
