pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=plasma-workspace
pkg_version=${_plasmaver}
pkg_description='Provides the interface and basic tools for the KDE Plasma Workspace'
pkg_upstream_url='https://projects.kde.org/projects/kde/workspace/plasma-workspace'
pkg_license=('LGPL')
pkg_deps=('frameworkintegration' 'kcmutils' 'knotifyconfig' 'krunner' 'kdesu' 'knewstuff' 'khtml'
         'libdbusmenu-qt5' 'glu' 'kjsembed' 'libxkbfile' 'libxcursor' 'lm_sensors' 'libraw1394'
         'libusb' 'pciutils' 'libbsd' 'kf5-attica' 
         'kemoticons' 'libxrandr' 'kded' 'kwin' 'libksysguard' 'ktexteditor' 'kde-cli-tools'
         'khelpcenter' 'kio-extras' 'baloo' 'milou' 'libkscreen' 'breeze' 'gpsd' 'libqalculate' 'qt5-tools'
         'qimageblitz' 'oxygen-icons5' 'prison' 'sddm-kcm' 'networkmanager-qt' 'kxmlrpcclient' 'kscreenlocker'
         'kactivitymanagerd' 'iso-codes' 'kholidays' 'plasma-l10n')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        '10-kf5'
        'kde.pam'
        'kde-np.pam'
        'kscreensaver.pam')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`
         'd102c44c3bddf29f6d440d1d582d4433'
         '6589fb28bd20d5ec1b4a7b9db9fc4209'
         '5a035421a9bfaa353caf04250c2b285c'
         '367a3538f54db71f108b34cfa31088ac')

prepare () {
  cd ${pkg_name}-${__pkg_version}
  # fix plasma hang on bogus autostart item
  #patch -p1 -i $CACHE_PATH/ea3f87c5df0251838da71c473fd7b790c932d8b0.diff
  #sed -i 's|org.kde.breeze.desktop|org.kde.midna.desktop|' shell/packageplugins/lookandfeel/lookandfeel.cpp
  sed -i 's|<default>1</default>|<default>2</default>|' applets/systemtray/package/contents/config/main.xml
}         
         
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
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
  
  sed 's|qtpaths|qtpaths-qt5|' -i $pkg_prefix/usr/bin/startkde
  sed 's|qdbus|qdbus-qt5|' -i $pkg_prefix/usr/bin/startkde
  sed 's|qtpaths|qtpaths-qt5|' -i $pkg_prefix/usr/bin/startplasmacompositor
  sed 's|qdbus|qdbus-qt5|' -i $pkg_prefix/usr/lib/startplasma
  
  install -Dm755 ${CACHE_PATH}/10-kf5 ${pkg_prefix}/etc/X11/xinit/xinitrc.d/10-kf5
  
  # install pam configuration, comment out for now, all provided by sddm
  #install -D -m644 ${CACHE_PATH}/kde.pam ${pkg_prefix}/etc/pam.d/kde
  #install -D -m644 ${CACHE_PATH}/kde-np.pam ${pkg_prefix}/etc/pam.d/kde-np
  #install -D -m644 ${CACHE_PATH}/kscreensaver.pam ${pkg_prefix}/etc/pam.d/kscreensaver
}
