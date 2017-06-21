pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kde-cli-tools
pkg_version=${_plasmaver}
pkg_description='Tools based on KDE Frameworks 5 to better interact with the system'
pkg_upstream_url='https://projects.kde.org/projects/kde/workspace/kde-cli-tools'
pkg_license=('LGPL')
pkg_deps=('kdesu' 'kdelibs4support' 'kcmutils' 'kemoticons' 'kinit' 'kitemmodels') # 'kf5trans')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/$pkg_name-$pkg_version.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-$_plasmaver.tar.gz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DLIBEXEC_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
  
  # place kdesu in bin too
  ln -sf /usr/lib/kf5/kdesu ${pkg_prefix}/usr/bin/
}

