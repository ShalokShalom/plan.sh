pkg_origin=
# convert to cmake build with 3.4, 3.3 not ready yet
pkg_name=qbittorrent
pkg_version=3.3.13
_commit=46e2e5342bb5b6f7a479f9ec7746e58d28ff783e
pkg_description="Bittorrent client programmed in C++ / Qt that uses libtorrent (sometimes called libtorrent-rasterbar)"
pkg_upstream_url="http://www.qbittorrent.org/"
pkg_license=('GPL')
pkg_deps=('qt5-base' 'libtorrent-rasterbar' 'xdg-utils' 'boost-libs' 'python2')
pkg_build_deps=('boost' 'which' 'qt5-tools')
pkg_source=("https://sourceforge.net/projects/qbittorrent/files/${pkg_name}/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/qbittorrent/qBittorrent/commit/729c80f9104a3d01ec724351bd6910b4b8d14c6c.diff")
#pkg_source=("https://github.com/qbittorrent/qBittorrent/archive/${_commit}.zip")
pkg_shasum=('4a61d9d3703b4bdbb7d9e8126a6cd5a8'
         '4775c7af320aea4c7e103a3591690806')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # revert commit, needs unreleased libtorrent-rasterbar
  #patch -Rp1 -i ${CACHE_PATH}/729c80f9104a3d01ec724351bd6910b4b8d14c6c.diff
}

do_build() {
    cd ${pkg_name}-${pkg_version}
    
    ./configure --prefix=/usr 
    make
}

do_package(){
    cd ${pkg_name}-${pkg_version}
    
    make INSTALL_ROOT=${pkg_prefix} install
}
