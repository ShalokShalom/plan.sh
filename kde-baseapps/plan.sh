pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kde-baseapps
pkg_version=16.07.80
_commit=12d2a6d6b279cdb8cc17d0ca8ac7fd041862f162
pkg_description="Collection of applications used for file and Internet browsing"
pkg_upstream_url='https://projects.kde.org/projects/kde/applications/kde-baseapps'
pkg_license=('LGPL')
pkg_deps=('karchive' 'kbookmarks' 'kcoreaddons' 'kconfig' 'kconfigwidgets' 'kdbusaddons' 'kio' 'kparts' 'kcmutils'
         'kdelibs4support' 'kdesu' 'kactivities' 'kded' 'khtml' 'knewstuff' 'kcrash' 'ki18n'
         'tidyhtml' 'dolphin' 'qtwebengine') # 'qtspeech')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
           'kde-baseapps-dolphin' 
           'kde-baseapps-konqueror' 
           'kde-baseapps-konq-plugins' 
           'kde-baseapps-kwrite')
          'kde-baseapps-dolphin' 
          'kde-baseapps-konqueror' 
          'kde-baseapps-konq-plugins' 
          'kde-baseapps-kwrite')
          'kde-baseapps-dolphin' 
          'kde-baseapps-konqueror' 
          'kde-baseapps-konq-plugins' 
          'kde-baseapps-kwrite')
#pkg_source=("http://download.kde.org/unstable/plasma/$pkg_version/src/${_pkg_name}-$pkg_version.tar.xz")
pkg_source=("https://github.com/KDE/kde-baseapps/archive/${_commit}.zip")
pkg_shasum=('c97e6b12523c6ed55552b50846f9dfa8')

do_prepare() {
  cd $pkg_name-${_commit}
  sed -i -e 's|#include <buffio.h>|#include <tidybuffio.h>|' konqueror/plugins/validators/tidy_validator.cpp
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
  
  # konqueror kf5 is not usable
  #rm -r ${pkg_prefix}/usr/share/applications/konquerorsu.desktop
  #rm -r ${pkg_prefix}/usr/share/applications/konqbrowser.desktop
  #rm -r ${pkg_prefix}/usr/bin/konqueror
}
