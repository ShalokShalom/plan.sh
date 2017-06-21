pkg_origin=

pkg_name=webcamoid
pkg_version=8.0.0
pkg_description="Webcamoid is a full featured webcam capture application."
pkg_upstream_url='https://webcamoid.github.io/'
pkg_license=('GPL')
pkg_deps=('qt5-quickcontrols' 'qt5-svg' 'ffmpeg' 'v4l-utils' 'kdesu')
pkg_build_deps=('qt5-tools')
pkg_source=("https://github.com/webcamoid/webcamoid/archive/${pkg_version}.tar.gz")
pkg_shasum=('ce7fdfacfec6f0a50791c639d2a6bd42')

do_build() {
  cd webcamoid-${pkg_version}

  /usr/lib/qt5/bin/qmake Webcamoid.pro 
  make -j1
}

do_package() {
  cd webcamoid-${pkg_version}

  make INSTALL_ROOT=${pkg_prefix} install
}
