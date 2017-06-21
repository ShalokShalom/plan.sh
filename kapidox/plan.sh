pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kapidox
pkg_version=${_kf5ver}
pkg_description='Frameworks API Documentation Tools'
pkg_upstream_url='https://github.com/KDE/kapidox'
pkg_license=('LGPL')
pkg_deps=('python3-jinja')
pkg_build_deps=('extra-cmake-modules' 'qt5-base')
pkg_source=("http://download.kde.org/stable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  python3 setup.py install --root=${pkg_prefix}
}
