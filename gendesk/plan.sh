pkg_origin=

pkg_name=gendesk
pkg_version=0.6.4
pkg_description="Utility to generate .desktop files and download icons"
pkg_upstream_url="http://roboticoverlords.org/gendesk/"
pkg_license=('MIT')
pkg_deps=('glibc')
pkg_build_deps=('go' 'mercurial')
pkg_source=("http://roboticoverlords.org/gendesk/${pkg_name}-${pkg_version}.tar.xz"
        "http://roboticoverlords.org/images/default.png")
pkg_shasum=('852ee801ec0ac311ac4c494bf79aa1c4'
         '76e9160caf563badd49c13f34cd137cf')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  GOPATH=`pwd` go get -d -v
  GOPATH=`pwd` go build
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  install -Dm755 ${pkg_name}-${pkg_version} ${pkg_prefix}/usr/bin/${pkg_name}
  install -Dm644 $CACHE_PATH/default.png ${pkg_prefix}/usr/share/pixmaps/default.png
  install -Dm644 ${pkg_name}.1.gz ${pkg_prefix}/usr/share/man/man1/${pkg_name}.1.gz
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
