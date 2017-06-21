pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=syndication
pkg_version=${_kdever}
pkg_description="Parser library for RSS and Atom feeds."
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/syndication'
pkg_license=('LGPL')
pkg_deps=('kio' 'kcodecs')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/syndication.git")
#pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's/add_subdirectory(autotests)/#add_subdirectory(autotests)/' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
}

do_build() {
  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING:BOOL=FALSE 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
