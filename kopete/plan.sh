pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kopete
#pkg_version=${_kdever}
pkg_version=17.03.71
_commit=285c9aadaa5f584bf52899fc7233557cae67f62c
pkg_description='Instant Messenger'
pkg_upstream_url='http://kde.org/applications/internet/kopete/'
pkg_license=('GPL' 'LGPL' 'FDL')
#groups=('kde' 'kdenetwork' 'kde-uninstall' 'network')
pkg_deps=('kcoreaddons' 'ki18n' 'kcmutils' 'khtml' 'knotifyconfig' 'kparts' 'kwallet'
         'kdelibs4support' 'ktexteditor' 'kcrash' 'kconfig' 'kemoticons' 'kdbusaddons' 'kdnssd'
         'kcontacts' 'kidentitymanagement' 'libkleo' 'gpgme'        
         'libotr' 'libidn' 'qimageblitz' 'libxss' 'v4l-utils' # 'mediastreamer' 'ortp' 'libgadu' 
         'jsoncpp' 'qca-qt5' 'sqlite' 'speex' 'phonon-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
#pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
#pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("https://github.com/KDE/kopete/archive/${_commit}.zip")
pkg_shasum=('f34fcb9bdb3031e7b761dfab0cee53d2')

do_prepare() {
  cd ${pkg_name}-${_commit}
  sed -i -e 's|NAMES kleo/kleo_export.h|NAMES KF5/libkleo/kleo_export.h|' cmake/modules/FindKleopatra.cmake
  #patch -p1 -i "$CACHE_PATH/kde_bug309119.diff" 
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DCMAKE_SKIP_RPATH=ON \
    -DDWITH_jabber=OFF \
    -DWITH_skype=ON
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
