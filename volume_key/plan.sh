pkg_origin=cosmos

pkg_name=volume_key
pkg_version=0.3.9
pkg_description="Library for manipulating storage volume encryption keys and storing them separately from volumes"
pkg_upstream_url="https://pagure.io/volume_key"
pkg_license=('GPL')
pkg_deps=('cryptsetup' 'nss' 'util-linux' 'gpgme')
pkg_source=("https://releases.pagure.org/volume_key/${pkg_name}-${pkg_version}.tar.xz"
        'config_h.patch')
pkg_shasum=('a2d14931177c660e1f3ebbcf5f47d8e2'
         'a55a060f489ac5243d84e9bffd5c994f')

do_build() {
    patch -p1 -i ${CACHE_PATH}/config_h.patch
    
    ./configure --prefix=/usr         
    make
}

do_package() {

    make DESTDIR=${CACHE_PATH}/ install
}
 
