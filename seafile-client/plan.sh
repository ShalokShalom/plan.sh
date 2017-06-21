pkg_origin=

pkg_name=seafile-client
pkg_version=6.0.6
_commit=c371897
pkg_description="Seafile desktop client."
pkg_upstream_url="https://github.com/haiwen/seafile-client/"
pkg_license=('Apache' 'GPLv3')
pkg_deps=('qtwebengine' 'seafile')
pkg_build_deps=('libtool' 'intltool' 'vala' 'cmake' 'qt5-tools' 'libevent')
pkg_source=("https://github.com/haiwen/seafile-client/archive/v${pkg_version}.tar.gz")
#pkg_source=("https://github.com/haiwen/seafile-client/tarball/qt5/sea-client-${pkg_version}.tar.gz")
pkg_shasum=('7013b00a8b13aac70f53aaaf931aa106')

do_build() {
  #cd haiwen-${pkg_name}-${_commit}
  cd ${pkg_name}-${pkg_version}
  sed -i -e 's|NAMES qmake qmake.exe|NAMES qmake-qt5 qmake.exe|' CMakeLists.txt
  
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHIBBOLETH_SUPPORT=ON 
  make
}

do_package() {
  #cd haiwen-${pkg_name}-${_commit}
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
