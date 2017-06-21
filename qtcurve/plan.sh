pkg_origin=

pkg_name=qtcurve
pkg_version=1.8.18.17
_commit=ec221dd9bbeb6c0cd255652877b7fc61c179ef0e
pkg_license=('GPL')
pkg_description='The QtCurve style engine for Qt5 and Plasma 5.'
pkg_upstream_url='https://projects.kde.org/projects/playground/base/qtcurve'
pkg_deps=('karchive' 'kconfig' 'kconfigwidgets' 'frameworkintegration' 'ki18n' 'kdelibs4support'
         'kio' 'kwidgetsaddons' 'kwindowsystem' 'kxmlgui' 'kguiaddons' 'kiconthemes' 
         'libx11' 'qt5-x11extras' 'qt5-svg')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://github.com/KDE/qtcurve/archive/${_commit}.zip"
        'DBus_crashing.diff')
pkg_shasum=('222c547bf5ced1bd9089afc9e7b9906e'
         'cf91da3678fcd6e31030b06f9e0560b4')

do_prepare() {
  cd ${pkg_name}-${_commit}
  
  #patch -p0 -i ${CACHE_PATH}/DBus_crashing.diff
}

do_build() {
    mkdir -p build
    cd build
    
    cmake ../${pkg_name}-${_commit} \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DENABLE_GTK2=false \
        -DQTC_QT5_ENABLE_KDE=true \
        -DQTC_QT4_ENABLE_KDE=false
    make
}

do_package() {
    cd build
	
    make DESTDIR=${pkg_prefix} install
}
