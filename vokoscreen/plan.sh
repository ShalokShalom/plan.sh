pkg_origin=

pkg_name=vokoscreen
pkg_version=2.5.4
_commit=4b1cf23f8857ad11ca168b4aed8f048d95d3d6dc
pkg_description="Easy to use screencast creator to record educational videos, videoconferences, etc"
pkg_upstream_url="http://www.kohaupt-online.de/"
pkg_license=('GPL2')
pkg_deps=('qt5-x11extras' 'ffmpeg' 'lame' 'pulseaudio-alsa' 'alsa-utils' 'v4l-utils' 'mpv'
         'qt5-multimedia')
pkg_build_deps=('cmake' 'qt5-tools')
#pkg_source=("https://github.com/vkohaupt/vokoscreen/archive/$_pkg_version.tar.gz")
pkg_source=("https://github.com/vkohaupt/vokoscreen/archive/${_commit}.zip")
pkg_shasum=('8de603edf511120eee215b718273da34')

do_build() {
    cd ${pkg_name}-${_commit}
    
    /usr/lib/qt5/bin/qmake ${pkg_name}.pro \
      "CONFIG+=LINUX_INTEGRATED" \
      "INSTALL_ROOT_PATH=${pkg_prefix}/usr/" \
      "CONFIG+=release" \
      "CONFIG+=c++14"
    make -j1
}

do_package() {
    cd ${pkg_name}-${_commit}
    
    make INSTALL_ROOT=${pkg_prefix} install
}
