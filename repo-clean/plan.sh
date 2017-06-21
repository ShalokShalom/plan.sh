pkg_origin=cosmos

pkg_name=repo-clean
pkg_version=0.1.4
pkg_description="Clean utility for Pacman repository"
pkg_upstream_url="http://code.google.com/p/repo-clean/"
pkg_license=('GPL')
pkg_deps=('boost-libs' 'pacman') 
pkg_build_deps=('boost' 'cmake' 'gcc' 'scons')
pkg_source=("https://github.com/downloads/luolimao/repo-clean-xz/${pkg_name}-xz-${pkg_version}.tar.bz2")
pkg_shasum=('b9d7ddfe83ef1c6e19786d6d428ade6e')

do_build() {
  cd ${pkg_name}-xz-${pkg_version}
  
  scons
}

do_package() {
  cp -rf ${pkg_name}-xz-${pkg_version}/dist/ ${pkg_prefix}/usr/
}
