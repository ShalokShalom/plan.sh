pkg_origin=

pkg_name=krita
pkg_version=3.1.4
_pkg_version=3.1.4
pkg_description="Program for sketching and painting, offering an end–to–end solution for creating digital painting files from scratch"
pkg_upstream_url='https://krita.org/'
pkg_license=('FDL1.2' 'GPL2' 'LGPL')
pkg_deps=('karchive' 'kcompletion' 'kconfig' 'kcoreaddons' 'kguiaddons' 'ki18n' 
         'kiconthemes' 'kitemmodels' 'kitemviews' 'ktextwidgets' 'kwidgetsaddons' 'kwindowsystem'
         'kio' 'kimageformats'
         'eigen3' 'gsl' 'lcms2' 'openexr' 'vc' 'opencolorio' 'poppler-qt5' 'hicolor-icon-theme' 'exiv2'
         'libraw' 'qca-qt5' 'qt5-svg' 'boost-libs')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost' 'qt5-tools') # 'clang') 
pkg_source=("https://download.kde.org/stable/krita/${_pkg_version}/${pkg_name}-${_pkg_version}.tar.gz"
        'launch_krita.sh')
pkg_shasum=('ed9c4eaf7e552b744c568f79fc6461d3'
         '673003bb648af0d4f801043ee0a17c2a')

do_prepare() {
  cd ${pkg_name}-${_pkg_version}
  sed -i 's|X-KDE-Import": "image/x-krita-raw|X-KDE-Import": "image/x-nikon-nef,image/x-canon-cr2,image/x-sony-sr2,image/x-canon-crw,image/x-pentax-pef,image/x-sigma-x3f,image/x-kodak-kdc,image/x-minolta-mrw,image/x-sony-arw,image/x-kodak-k25,image/x-kodak-dcr,image/x-olympus-orf,image/x-panasonic-raw,image/x-panasonic-raw2,image/x-fuji-raf,image/x-sony-srf,image/x-adobe-dng|' plugins/impex/raw/krita_raw_import.json
}

do_build() {
  mkdir -p build
  cd build
  
  #export CC=/usr/bin/clang
  #export CXX=/usr/bin/clang++
  
  cmake ../${pkg_name}-${_pkg_version} \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=FALSE 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  # don't override system defaults
  install -Dm755 ${CACHE_PATH}/launch_krita.sh ${pkg_prefix}/usr/bin/launch_krita.sh
  sed 's|Exec=krita %U|Exec=launch_krita.sh|' -i ${pkg_prefix}/usr/share/applications/org.kde.krita.desktop
}

