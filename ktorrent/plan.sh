pkg_origin=

pkg_name=ktorrent
pkg_version=5.0.1.1
_commit=499ed1dffaff60a37e60fa566254188ee970bfdf
ktorver=5.0
pkg_description="A BitTorrent program for KDE"
pkg_upstream_url="http://ktorrent.pwsp.net/"
pkg_license=('GPL2')
pkg_deps=('kdelibs4support' 'ki18n' 'kio' 'kxmlgui' 'knotifications' 'knotifyconfig' 'solid'
         'kconfig' 'kcoreaddons' 'kross' 'kcmutils' 'sonnet' 'kdbusaddons' 'kcrash' 'kdnssd'
         'taglib' 'libktorrent' 'plasma-workspace' 'kdewebkit')
pkg_build_deps=('extra-cmake-modules' 'boost' 'kdoctools')
install=ktorrent.install
#pkg_source=("http://download.kde.org/stable/ktorrent/${ktorver}/${pkg_name}-${pkg_version}.tar.xz")
pkg_source=("https://github.com/KDE/ktorrent/archive/${_commit}.zip")
pkg_shasum=('934ddf0ec035de18d82bb15bbce1f35c')

do_prepare() {
  cd ${pkg_name}-${_commit}

  #sed -i 's|TARGETS ktorrent_app ${INSTALL_TARGETS_DEFAULT_ARGS}|TARGETS ktorrent_app ${KDE_INSTALL_TARGETS_DEFAULT_ARGS}|g' ktorrent/CMakeLists.txt
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
