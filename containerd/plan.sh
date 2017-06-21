pkg_origin=

# stay with _commit builds, keep in sync with what docker ships
pkg_name=containerd
pkg_version=0.2.4
_commit=9048e5e50717ea4497b757314bad98ea3763c145
pkg_description="Daemon to control runC, built for performance and density."
pkg_upstream_url="https://containerd.tools/"
pkg_license=('APACHE')
pkg_deps=('runc')
pkg_build_deps=('go')
#pkg_source=("https://github.com/docker/containerd/archive/v${pkg_version}.tar.gz")
pkg_source=("https://github.com/docker/containerd/archive/${_commit}.zip")
pkg_shasum=('6427b24464a9fb232cc7c68edcffd818')

do_prepare() {
    cd ${CACHE_PATH}
    
    install -d src/github.com/docker
    mv ${pkg_name}-${_commit} src/github.com/docker/${pkg_name}
}

do_build() {
    cd src/github.com/docker/${pkg_name}
    
    LDFLAGS="" GOPATH="$CACHE_PATH:$CACHE_PATH/${pkg_name}/vendor" make
}

do_package() {
    cd src/github.com/docker/${pkg_name}/bin
    
    install -Dm755 containerd ${pkg_prefix}/usr/bin/containerd
    install -Dm755 containerd-shim ${pkg_prefix}/usr/bin/containerd-shim
    install -Dm755 ctr ${pkg_prefix}/usr/bin/ctr
}
