pkg_origin=

pkg_name=soundkonverter
pkg_version=2.2.2
_commit=81287bc6495cc2880912681ae83accff1ea73472
pkg_description="SoundKonverter is a frontend to various audio converters"
pkg_upstream_url="https://github.com/isoft-linux/soundkonverter/"
pkg_license=('GPL')
pkg_deps=('ki18n' 'kxmlgui' 'kio' 'solid' 'kconfig' 'kconfigwidgets' 'kwidgetsaddons' 'kdelibs4support'
         'libkcddb5' 'taglib' 'ffmpeg' 'cdparanoia' 'phonon-qt5' 'sox' 'vorbis-tools' 'wavpack' 'speex'
         'flac' 'timidity++' 'opus')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("http://kde-apps.org/CONTENT/content-files/29024-soundkonverter-${pkg_version}.tar.gz")
#pkg_shasum=('4f09193d6602de7952b985b9505731f8')
pkg_source=("https://github.com/isoft-linux/soundkonverter/archive/${_commit}.zip")
pkg_shasum=('06a19122ff29bb7f2c0ce51b5fbe74b1')

do_prepare() {
  cd ${pkg_name}-${_commit}
  #sed -i -e 's|add_custom_target|#add_custom_target|' ${CACHE_PATH}/${pkg_name}/src/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit}/src \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKF5_BUILD=ON 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
