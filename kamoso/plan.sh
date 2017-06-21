pkg_origin=

pkg_name=kamoso
pkg_version=3.2.3
_pkg_version=3.2
pkg_description="Kamoso is an application to take pictures and videos out of your webcam."
pkg_upstream_url="https://projects.kde.org/projects/extragear/multimedia/kamoso"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kcompletion' 'kwidgetsaddons' 'kio' 'solid'
         'systemd' 'gst-plugins-base' 'gst-plugins-good' 'qt5-gstreamer' 
         'kipi-plugins' 'phonon-qt5' 'qt5-graphicaleffects' 'qt5-quickcontrols' 'purpose')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'boost')
pkg_source=("http://download.kde.org/stable/kamoso/${_pkg_version}/src/kamoso-${pkg_version}.tar.xz")
pkg_shasum=('5d92d3a3219d53e9b3e8054b2327e06a')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd"|V4.5-Based Variant V1.1//EN" "dtd/kdedbx45.dtd"|' ${CACHE_PATH}/${pkg_name}/doc/index.docbook
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
  
  #sed -i 's|KAlgebra|Kamoso|' ${pkg_prefix}/usr/share/applications/org.kde.kamoso.desktop
  #sed -i 's|Exec=kamoso|Exec=kamoso -qwindowtitle %c|' ${pkg_prefix}/usr/share/applications/org.kde.kamoso.desktop
  #sed -i 's|Categories=Qt;KDE;Multimedia|Categories=Qt;KDE;AudioVideo;|' ${pkg_prefix}/usr/share/applications/org.kde.kamoso.desktop
}
