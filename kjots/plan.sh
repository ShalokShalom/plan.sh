pkg_origin=

pkg_name=kjots
pkg_version=5.0.2
_commit=d36f81a92266d696a263564519428adc19b53fe4
pkg_description="Note taking application for KDE using Akonadi"
pkg_upstream_url="https://projects.kde.org/projects/playground/pim/kjots"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcmutils' 'kio' 'kconfig' 'kconfigwidgets' 'kparts' 'kbookmarks' 'kxmlgui' 'ktextwidgets'
         'akonadi' 'kmime' 'akonadi-notes' 'kpimtextedit' 'kontactinterface'
         'grantlee')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
#pkg_source=("https://github.com/KDE/kjots/archive/${_commit}.zip"
pkg_source=("http://download.kde.org/stable/kjots/${pkg_version}/kjots-${pkg_version}.tar.xz"
        "https://github.com/KDE/kjots/commit/d536dbdf606d18baa437d03a9852fa6bb7289953.diff"
        "https://github.com/KDE/kjots/commit/01fc847ef4baefddbaade39cfb97f9e7d59b0cc8.diff")
pkg_shasum=('296136e9860142596235d6d3f2c523e8'
         'c425116b8dbdcec2f6860f1c691c3026'
         'd41cdc0e93e6b0a641ecd321cd7cacaa')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  # fix .desktop file
  #patch -p1 -i ${CACHE_PATH}/d536dbdf606d18baa437d03a9852fa6bb7289953.diff
  # fix build, not finding ktextwidgets
  #patch -p1 -i ${CACHE_PATH}/01fc847ef4baefddbaade39cfb97f9e7d59b0cc8.diff
}
  
do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=FALSE 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
