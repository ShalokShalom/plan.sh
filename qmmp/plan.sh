pkg_origin=

pkg_name=qmmp
pkg_version=1.1.9
_pkg_version=1.1.9
_commit=dev-code-5352-branches-qmmp-1.0
pkg_description="Qt based audio-player"
pkg_upstream_url="http://qmmp.ylsoftware.com/"
pkg_license=('GPL')
pkg_deps=('alsa-lib' 'curl' 'hicolor-icon-theme' 'libmad' 'libvorbis' 'libogg'  'qt5-x11extras'
         'taglib' 'xdg-utils' 'enca' 'opusfile' 'qt5-multimedia')
pkg_build_deps=('cmake'  'flac' 'jack' 'libmpcdec' 'ffmpeg' 'libsamplerate' 'libmodplug' 'libsndfile'
             'wavpack' 'libcdio-paranoia' 'mesa' 'qt5-tools')
optpkg_deps=('flac: native FLAC support'
            'jack: JACK sound output'
            'libmpcdec: Musepack support'
            'libmodplug: MOD playing library'
            'libsndfile: sampled sound support'
            'libcdio-paranoia: for audio CD playback support')
pkg_source=("https://sourceforge.net/projects/qmmp-dev/files/qmmp/qmmp-${_pkg_version}.tar.bz2")
#pkg_source=("http://sourceforge.net/code-snapshots/svn/q/qm/qmmp-dev/code/qmmp-${_commit}.zip")
pkg_shasum=('7f41f0deb2b48b1e37fd96039ea977e8')

do_build() {
  cd ${pkg_name}-${_pkg_version}

  cmake . -DCMAKE_INSTALL_PREFIX=/usr 
  make
}

do_package() {
  cd ${pkg_name}-${_pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
