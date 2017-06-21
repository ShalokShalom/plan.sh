pkg_origin=

pkg_name=obs-studio
pkg_version=19.0.2
pkg_description="Free and open source software for video recording and live streaming."
pkg_upstream_url="https://obsproject.com/"
pkg_license=('GPL2')
pkg_deps=('ffmpeg' 'jansson' 'libxinerama' 'libxkbcommon' 'qt5-x11extras'
         'libxcomposite' 'x264' 'pulseaudio' 'vlc' 'jack')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/jp9000/obs-studio/archive/${pkg_version}.tar.gz")
pkg_shasum=('17faac785934d632fb2fbd142e09516f')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DUNIX_STRUCTURE=1 \
    -DOBS_VERSION_OVERRIDE=$pkg_version 
  make 
}

do_package() {
  cd build

  make install DESTDIR=${pkg_prefix}
}
