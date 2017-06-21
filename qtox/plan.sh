pkg_origin=
pkg_name=qtox
_pkg_name=qTox
pkg_version=1.10.2
_commit=0a1a781249f1c044dc06c67fda8966f7c91b743c
pkg_description='Powerful Tox client that follows the Tox design guidelines while running on all major platforms.'
pkg_upstream_url='https://qtox.github.io/'
pkg_license=('GPL3')
pkg_deps=('ffmpeg' 'filter_audio' 'libxkbcommon' 'libxss' 'openal' 'qrencode' 'qt5-svg'
         'sqlcipher' 'toxcore' 'libvpx')
pkg_build_deps=('qt5-tools')
pkg_source=("https://github.com/qTox/qTox/archive/v${pkg_version}.tar.gz")
#pkg_source=("https://github.com/qTox/qTox/archive/${_commit}.zip")
pkg_shasum=('43f72ddc1e5a5574cfe7418d2223e480')

do_build() {
  cd ${_pkg_name}-${pkg_version}
  mkdir -p build
  cd build
  
  /usr/lib/qt5/bin/qmake ENABLE_SYSTRAY_UNITY_BACKEND=NO \
                         ENABLE_SYSTRAY_STATUSNOTIFIER_BACKEND=NO \
                         ENABLE_SYSTRAY_GTK_BACKEND=NO \
                         DISABLE_FILTER_AUDIO=NO ..
  make
}

do_package() {
  cd ${_pkg_name}-${pkg_version}/build

  make INSTALL_ROOT=${pkg_prefix}/ install
}
