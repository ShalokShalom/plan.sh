pkg_origin=cosmos

pkg_name=libblockdev
pkg_version=2.8.1
_pkg_version=2.8-1
pkg_description="C library supporting GObject introspection for manipulation of block devices."
pkg_upstream_url="http://www-rhstorage.rhcloud.com/projects/libblockdev"
pkg_license=('LGPL')
pkg_deps=('btrfs-progs' 'cryptsetup' 'kmod' 'libbytesize' 'lvm2' 'nss' 'parted' 
         'python3' 'systemd' 'util-linux' 'volume_key')
pkg_build_deps=('gobject-introspection' 'python3-six') # 'dmraid')
pkg_source=("https://github.com/rhinstaller/libblockdev/archive/${pkg_name}-${_pkg_version}.tar.gz"
        "https://github.com/rhinstaller/libblockdev/commit/50dec146ddd6c77f5989aa359a545ab676437169.diff"
        "https://github.com/rhinstaller/libblockdev/commit/5d6617ffaec72a38a61f7e6fe2a102a9a3a5ca94.diff")
pkg_shasum=('7199200a0596647e4592b838dcfce56b'
         '9610c23df7c73e74ddebffce971614c3'
         '1728a015f4102da2c27732e512bbd549')

prepare() {
    
    patch -p1 -i ${CACHE_PATH}/50dec146ddd6c77f5989aa359a545ab676437169.diff
    patch -p1 -i ${CACHE_PATH}/5d6617ffaec72a38a61f7e6fe2a102a9a3a5ca94.diff
}

do_build() {
    
    ./autogen.sh
    ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --with-python3=yes \
        --without-dm 
        #--without-mdraid
        #--without-lvm \
        #--without-lvm_dbus \
        #--without-mpath
        
    make
}

do_package() {

    make DESTDIR=${pkg_prefix}/ install
}
 
