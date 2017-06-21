pkg_origin=

pkg_name=gparted
pkg_version=0.28.1
pkg_description="A Partition Magic clone, frontend to GNU Parted."
pkg_upstream_url="http://gparted.sourceforge.net"
pkg_license=('GPL')
pkg_deps=('parted' 'gtkmm' 'hicolor-icon-theme')
pkg_build_deps=('intltool' 'pkg-config' 'gnome-doc-utils')
optpkg_deps=('dosfstools: for FAT16 and FAT32 partitions'
            'jfsutils: for jfs partitions'
            'ntfs-3g: for ntfs partitions'
            'reiserfsprogs: for reiser partitions'
            'xfsprogs: for xfs partitions')
pkg_source=("http://downloads.sourceforge.net/project/gparted/gparted/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
        'gparted.desktop')
pkg_shasum=('ab72464a3ab2137664d9df8462befd3f'
         '76b565bf67ffb527786070825f613aa7')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  rm ${pkg_prefix}/usr/share/applications/gparted.desktop
  install -m 644 -p ${CACHE_PATH}/gparted.desktop ${pkg_prefix}/usr/share/applications/
}
