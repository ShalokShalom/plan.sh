pkg_origin=

# stay with _commit builds, keep in sync with what docker ships
pkg_name=docker-proxy
pkg_version=0.7.80
# LIBNETWORK_COMMIT=7b2b1feb1de4817d522cc372af149ff48d25028e
_commit=7b2b1feb1de4817d522cc372af149ff48d25028e
pkg_description="Docker container Networking"
pkg_upstream_url="http://github.com/docker/libnetwork"
pkg_license=('APACHE')
pkg_deps=('glibc')
pkg_build_deps=('go')
pkg_source=("https://github.com/docker/libnetwork/archive/${_commit}.zip")
pkg_shasum=('94241f88ddfba3ebcd169a91910e16be')

do_build() {
    cd libnetwork-${_commit}
    export GOPATH=~/gocode
    export PATH=$PATH:$GOPATH/bin
    
    go build -o "bin/docker-proxy" ./cmd/proxy
}

do_package() {
    cd libnetwork-${_commit}
    
    install -Dm755 bin/docker-proxy ${pkg_prefix}/usr/bin/docker-proxy
}
