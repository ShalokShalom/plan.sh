pkg_origin=

# stay with _commit builds, keep in sync with what docker ships
pkg_name=runc
pkg_version=0.1.1
_commit=9c2d8d184e5da67c95d601382adf14862e4f2228
pkg_description="CLI tool for spawning and running containers according to the OCI specification."
pkg_upstream_url="http://runc.io/"
pkg_license=('APACHE')
pkg_deps=('glibc')
pkg_build_deps=('go')
#pkg_source=("https://github.com/opencontainers/runc/archive/v${pkg_version}.tar.gz")
pkg_source=("https://github.com/opencontainers/runc/archive/${_commit}.zip")
pkg_shasum=('c26a791455abdb56ea62ebb683f7d8fa')

do_build() {
    cd runc-${_commit}
    export GOPATH=~/gocode
    export PATH=$PATH:$GOPATH/bin
    
    make
}

do_package() {
    cd runc-${_commit}
    
    install -Dm755 runc ${pkg_prefix}/usr/bin/runc
}
