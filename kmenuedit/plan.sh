pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kmenuedit
pkg_version=${_plasmaver}
pkg_description='KDE menu editor'
pkg_upstream_url='https://projects.kde.org/projects/kde/workspace/kmenuedit'
pkg_license=('LGPL')
pkg_deps=('khotkeys')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/unstable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  rm -r ${pkg_prefix}/usr/share/locale
}
