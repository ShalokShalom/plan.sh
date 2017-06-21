pkg_origin=cosmos

pkg_name=qoauth
pkg_version=2.0.1
_commit=02fbc13
pkg_description="Support with OAuth-powered network services"
pkg_upstream_url="http://github.com/ayoy/qoauth"
pkg_license=('GPL')
pkg_deps=('qca-qt5')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/ayoy/qoauth/tarball/master/qoauth-${pkg_version}.tar.gz")
pkg_shasum=('66e73344eba0007a50a35833d9b6a309')

do_build() {
  # Move libraries from /usr/lib64 to /usr/lib
  sed -i 's|lib64|lib|' src/src.pro
  
  /usr/lib/qt5/bin/qmake
  make
}

do_package() {
  
  make INSTALL_ROOT=${CACHE_PATH} install

  
}
