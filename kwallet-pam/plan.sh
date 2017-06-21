pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kwallet-pam
pkg_version=${_plasmaver}
pkg_description="Kwallet-pam is added to open your wallet on login"
pkg_upstream_url="https://projects.kde.org/projects/kdereview/kwallet-pam"
pkg_license=('LGPL')
pkg_deps=('kwallet' 'pam' 'socat')
pkg_build_deps=('extra-cmake-modules')
#groups=('plasma5')
pkg_source=("http://download.kde.org/unstable/plasma/${pkg_version}/${pkg_name}-${_plasmaver}.tar.xz")
#pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build  
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DLIBEXEC_INSTALL_DIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
