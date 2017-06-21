pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kimap
pkg_version=${_kdever}
pkg_description="Job-based API for interacting with IMAP servers"
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/kimap'
pkg_license=('LGPL')
pkg_deps=('kcoreaddons' 'kdelibs4support' 'kmime') # 'ki18n' 'kio'
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kimap.git")
#pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name-${pkg_version}
  # https://bugs.kde.org/show_bug.cgi?id=352223
  #sed -i -e 's|utcDateTime.toString(QString::fromAscii|QLocale::c().toString(utcDateTime, QString::fromAscii|' src/appendjob.cpp
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
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
