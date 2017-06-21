pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdenetwork-filesharing
pkg_version=${_kdever}
#pkg_version=15.07.71
pkg_description='Properties dialog plugin to share a directory with the local network'
pkg_upstream_url='https://projects.kde.org/projects/kde/kdenetwork/kdenetwork-filesharing'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kinit' 'kcmutils' 'knewstuff' 'kcoreaddons' 'ki18n' 'kio' 'kdbusaddons' 'kbookmarks' 'kconfig'
         'kparts' 'solid' 'kiconthemes' 'kcompletion' 'ktexteditor' 'kwindowsystem' 'knotifications'
         'kwidgetsaddons'  'kdelibs4support' 'samba')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kdenetwork-filesharing.git#branch=frameworks")
#pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #patch -p1 -i ${CACHE_PATH}/cmake.diff
}

do_build() {
  mkdir build 
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=$pkg_prefix install
}
