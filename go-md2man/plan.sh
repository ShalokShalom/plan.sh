pkg_origin=

pkg_name=go-md2man
pkg_version=1.0.6
pkg_description='Pure Go written standard markdown formatted documents to manpages converter.'
pkg_upstream_url='https://github.com/cpuguy83/go-md2man'
pkg_license=('MIT')
pkg_build_deps=('git' 'go')
pkg_source=("${pkg_name}.tar.gz::https://github.com/cpuguy83/go-md2man/archive/v${pkg_version}.tar.gz")
pkg_shasum=('ebcb4cda658089e8b8653c09b0d101d7')

do_build() {
  export GOPATH=$(readlink -f .)
  local repo=src/github.com/cpuguy83
  
  mkdir -p ${repo}
  ln -sf ../../../go-md2man-${pkg_version} ${repo}/go-md2man
  
  cd ${repo}/go-md2man
  go get -v ./...
  ${CACHE_PATH}/bin/go-md2man -in=go-md2man.1.md -out=go-md2man.1
}

do_package() {
  install -Dm755 bin/go-md2man ${pkg_prefix}/usr/bin/go-md2man
  install -Dm755 go-md2man-${pkg_version}/go-md2man.1 ${pkg_prefix}/usr/share/man/man1/go-md2man.1
}
