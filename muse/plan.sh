pkg_origin=

pkg_name=muse
pkg_version=2.9.70
_commit=6e2b81a1ac20dab32cd76edbc8d20d3899a612ed
pkg_description="MIDI/Audio sequencer with recording and editing capabilities, aims to be a complete multitrack virtual studio for Linux."
pkg_upstream_url='http://muse-sequencer.org/'
pkg_license=('GPL2')
pkg_deps=('qt5-svg' 'qt5-tools' 'dssi' 'fluidsynth' 'jack' 'ladspa' 'liblo' 'libsamplerate' 'libsndfile' 'lv2' 'lilv') 
pkg_build_deps=('cmake')
pkg_source=("https://github.com/muse-sequencer/muse/archive/${_commit}.zip")
pkg_shasum=('59878731efba8655fac2f6e6648d9fb0')

do_build() {
  mkdir -p build
  cd build 
  
  CXXFLAGS+="-std=c++11"
  
  cmake ../${pkg_name}-${_commit}/muse3 \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DENABLE_LV2_SUPPLIED=OFF \
    -DENABLE_EXPERIMENTAL=OFF \
    -DENABLE_PYTHON=OFF \
    -DENABLE_LASH=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
