pkg_origin=

pkg_name=rosegarden
pkg_version=17.04
_pkg_version=17.04
pkg_description="MIDI/audio sequencer and notation editor"
pkg_upstream_url="http://www.rosegardenmusic.com/"
pkg_license=('GPL')
pkg_deps=('liblrdf' 'dssi' 'fftw' 'perl' 'qt5-base' 'shared-mime-info' 'lilypond')
pkg_build_deps=('cmake' 'qt5-tools')
optpkg_deps=('cups: printing support'
            'okular: print preview, or any other PDF viewer'
            'flac'
            'wavpack')
pkg_source=("https://sourceforge.net/projects/rosegarden/files/${pkg_name}/${_pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('d3d80cc8e6eb3c7764a2905059acacce')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DUSE_QT5=TRUE
  make
}

do_package() {
  cd build 
  
  make DESTDIR="${pkg_prefix}" install
}
