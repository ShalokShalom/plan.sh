pkg_origin=cosmos

pkg_name=graphite
pkg_version=1.3.10
pkg_upstream_url="http://projects.palaso.org/projects/graphitedev/wiki"
pkg_description='reimplementation of the SIL Graphite text processing engine'
pkg_license=('custom_SIL Dual license')
pkg_deps=('gcc-libs')
pkg_build_deps=('cmake' 'freetype2' 'python2')
pkg_source=("https://github.com/silnrsi/graphite/releases/download/${pkg_version}/graphite2-${pkg_version}.tgz"
        'cmakepath.patch')
pkg_shasum=('b39d5ed21195f8b709bcee548c87e2b5'
         '00353b67941dbc30b76a43253760769e')

do_build() {
  # patch from Slackware
  pushd graphite2-${pkg_version}
  patch -p1 -i ${CACHE_PATH}/cmakepath.patch
  popd
  
  mkdir -p build
  
  cmake -G "Unix Makefiles" ../graphite2-${pkg_version} \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DGRAPHITE2_COMPARE_RENDERER=OFF 
  make
}

check() {
  
  ctest || true
}

do_package() {
  make DESTDIR=$pkg_prefix/ install

  mkdir -p ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 ${CACHE_PATH}/graphite2-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
