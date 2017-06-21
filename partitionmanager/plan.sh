pkg_origin=

pkg_name=partitionmanager
pkg_version=3.0.1
_commit=771c0ceaa2bfd5634f65e6e390733cec557e90de
epoch=1
pkg_description="Easily manage disks, partitions and file systems on your KDE Desktop"
pkg_upstream_url="https://www.kde.org/applications/system/kdepartitionmanager"
pkg_license=('GPL2')
pkg_deps=('kconfig' 'ki18n' 'kcrash' 'kinit' 'kio' 'kiconthemes' 'kjobwidgets' 'kwindowsystem' 'kxmlgui' 'kwidgetsaddons'
         'parted' 'libatasmart' 'udisks2' 'kpmcore')
pkg_build_deps=('extra-cmake-modules' 'pkgconfig' 'kdoctools')
optpkg_deps=('e2fsprogs: ext2/3/4 support'
            'xfsprogs: XFS support'
            'jfsutils: JFS support'
            'reiserfsprogs: Reiser support'
            'ntfsprogs: NTFS support'
            'dosfstools: FAT32 support')
pkg_source=("https://download.kde.org/stable/partitionmanager/${pkg_version}/src/partitionmanager-${pkg_version}.tar.xz")
#pkg_source=("https://github.com/KDE/partitionmanager/archive/${_commit}.zip")
pkg_shasum=('dee1c38e0e9e5f88b867c735e91d32f4')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # filsystem code from src/fs/filesystem.h, set as default
  #sed -i -e 's/FileSystem::Ext3/FileSystem::Xfs/' ${CACHE_PATH}/${pkg_name}-${pkg_version}/src/config.kcfg
  sed -i -e 's/FileSystem::Ext4/FileSystem::Xfs/' src/partitionmanager.kcfg
}

do_build() {
  mkdir build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DKDE_INSTALL_LIBDIR=lib \
        -DKDE_INSTALL_SYSCONFDIR=/etc \
        -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
        -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DBUILD_TESTING=OFF 

  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install 
}

