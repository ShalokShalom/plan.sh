pkg_origin=

pkg_name=sddm
pkg_version=20170603
_commit=27e254ac6e5c21736236537d132e3e993f4eb97c
pkg_description="QML based X11 display manager"
pkg_upstream_url="http://github.com/sddm/sddm"
pkg_license=('GPL')
pkg_deps=('qt5-declarative' 'libxcb')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools' 'python2-docutils')
backup=('etc/sddm.conf')
install=sddm.install
pkg_source=("https://github.com/sddm/sddm/archive/${_commit}.zip"
        'sddm.conf')
pkg_shasum=('a236aa166f9e8aacfc2916144edb15f3'
         '93fa7a39377cc02494f652ffd2018554')
         
do_prepare() {
  cd $pkg_name-${_commit}
  
  #patch -p1 -i ${CACHE_PATH}/combobox.diff
  sed -i -e 's|%1 (Wayland)|%1Wayland|' src/common/Session.cpp
}

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib/sddm \
    -DBUILD_MAN_PAGES=ON 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  install -m 644 -p ${CACHE_PATH}/sddm.conf ${pkg_prefix}/etc/
  install -d -g 136 -o 136 ${pkg_prefix}/var/lib/sddm
  #install -Dm644 $CACHE_PATH/wayland.desktop $pkg_prefix/usr/share/wayland-sessions/wayland.desktop
  # fix systemd 230 double mounting of /
  #sed -i 's|PrivateTmp=yes|PrivateTmp=no|' ${pkg_prefix}/usr/lib/systemd/system/sddm.service
}
