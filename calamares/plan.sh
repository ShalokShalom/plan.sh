pkg_origin=

pkg_name=calamares
pkg_version=3.1.0.9
pkg_description='Distribution-independent installer framework'
pkg_upstream_url='http://calamares.io/'
pkg_license=('LGPL')
pkg_deps=('qt5-svg' 'qtwebkit-tp' 'kconfig' 'ki18n' 'kcoreaddons' 'solid' 'yaml-cpp'
         'parted' 'libatasmart' 'udisks2' 'polkit-qt5' 'kpmcore' 'kparts' 'pythonqt')
pkg_build_deps=('extra-cmake-modules' 'git' 'qt5-tools') # 'clang')
#pkg_source=("git://github.com/KaOSx/calamares#commit=8d1145719acb6e3cc11d22f4ab4c61a1dfb9cd81"
pkg_source=("git://github.com/KaOSx/calamares"
#pkg_source=("git://github.com/demmm/calamares"
        'calamares.desktop'
        'installer.svg'
        'kdm_sddm.conf'
        'unpackfs.conf'
        'launch-calamares.sh'
        'license.pdf'
        'release_notes.html')
pkg_shasum=('SKIP'
         '663fce16ac08b3149516e6a0d2797f65'
         'd5c65f43e057054e9728810530c4a030'
         '184d5b6886fc7a6156d4b790657f77f4'
         '8b69a3a86923e2ee67a5a0725acb93e6'
         'fc92a5a0a1276a8e8f1a3327a0e567ee'
         'bb33b54d289cfe39ebfd78f172382880'
         'b191690a95fd8b0a618f95512ff555fd')

prepare () {
  cd ${pkg_name}
  
  git submodule init
  git submodule update
}

do_build() {
  #export CC=/usr/bin/clang
  #export CXX=/usr/bin/clang++
  
  mkdir -p build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DWITH_CRASHREPORTER=ON \
    -DWITH_PYTHONQT=ON \
    -DWEBVIEW_FORCE_WEBKIT=ON
  make
}

do_package() {
  cd build 
  make DESTDIR=${pkg_prefix} install
  
  install -Dm755 ${CACHE_PATH}/launch-calamares.sh ${pkg_prefix}/usr/bin/launch-calamares.sh
  rm -rf $pkg_prefix/usr/share/applications/$pkg_name.desktop
  install -Dm644 $CACHE_PATH/$pkg_name.desktop $pkg_prefix/usr/share/applications/$pkg_name.desktop
  install -Dm644 ${CACHE_PATH}/installer.svg ${pkg_prefix}/usr/share/pixmaps/installer.svg
  install -Dm644 $CACHE_PATH/license.pdf $pkg_prefix/usr/share/calamares/license.pdf
  install -Dm644 $CACHE_PATH/release_notes.html $pkg_prefix/usr/share/calamares/release_notes.html
}
