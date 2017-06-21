pkg_origin=

pkg_name=luckybackup
pkg_version=0.4.8
pkg_description="Backup & Sync tool using Rsync and Qt4"
pkg_upstream_url="http://luckybackup.sourceforge.net/"
pkg_license=('GPL3')
pkg_deps=( 'qt' 'rsync' 'openssh')
pkg_source=("http://sourceforge.net/projects/luckybackup/files/$pkg_version/source/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('f6dcf502c2f11b5d44837189bf00ee01')

do_build() {
     cd "${CACHE_PATH}/$pkg_name-$pkg_version"
     
     qmake 
}

do_package() {
     cd "${CACHE_PATH}/$pkg_name-$pkg_version"
     
     make INSTALL_ROOT=${pkg_prefix}/ install 
}
