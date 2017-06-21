pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kpty
pkg_version=${_kf5ver}
pkg_description='Library that provides primitives to interface with pseudo terminal devices and KProcess'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kpty'
pkg_license=('LGPL')
pkg_deps=('kcoreaddons' 'ki18n' 'libutempter')
pkg_build_deps=('extra-cmake-modules')
           'kdewebdev-kimageeditor'
           'kdewebdev-klinkstatus'
           'kdewebdev-kommander'
           'kdetoys-amor'
           'kdeutils-kfloppy'
           'kdeutils-kremotecontrol'
           'kdeutils-superkaramba'
           'kdegraphics-strigi-analyzer'
           'kde-base-artwork'
           'kde-thumbnailer-epub'
           'kdeaccessibility-jovie'
           'kdeaccessibility-kaccessible'
           'kdeaccessibility-kmousetool'
           'kdeadmin-kuser'
           'kdeartwork-colorschemes'
           'kdeartwork-desktopthemes'
           'kdeartwork-emoticons'
           'kdeartwork-iconthemes'
           'kdeartwork-screensavers'
           'kdeartwork-styles'
           'kdeartwork-wallpapers'
           'kdeartwork-weatherwallpapers'
           'kdemultimedia-kscd'
           'kdenetwork-kopete'
           'kdenetwork-strigi-analyzers'
           'kdenetwork-zeroconf-ioslave'
           'kdenetwork-kppp'
           'kdesdk-dev-utils'
           'kdesdk-kioslaves'
           'kdesdk-strigi-analyzers'
           'kde-plasma-themes-Kotonaru'
           'kotonaru-colors'
           'kde-kdm-themes-grey'
           'kdelibs-debug') 
           'kdewebdev-kimageeditor'
           'kdewebdev-klinkstatus'
           'kdewebdev-kommander'
           'kdetoys-amor'
           'kdeutils-kfloppy'
           'kdeutils-kremotecontrol'
           'kdeutils-superkaramba'
           'kdegraphics-strigi-analyzer'
           'kde-base-artwork'
           'kde-thumbnailer-epub'
           'kdeaccessibility-jovie'
           'kdeaccessibility-kaccessible'
           'kdeaccessibility-kmousetool'
           'kdeaccessibility-kmouth'
           'kdeadmin-kuser'
           'kdeartwork-colorschemes'
           'kdeartwork-desktopthemes'
           'kdeartwork-emoticons'
           'kdeartwork-iconthemes'
           'kdeartwork-screensavers'
           'kdeartwork-styles'
           'kdeartwork-wallpapers'
           'kdeartwork-weatherwallpapers'
           'kdemultimedia-kscd'
           'kdenetwork-kopete'
           'kdenetwork-strigi-analyzers'
           'kdenetwork-zeroconf-ioslave'
           'kdenetwork-kppp'
           'kdesdk-dev-utils'
           'kdesdk-kioslaves'
           'kdesdk-strigi-analyzers'
           'kde-plasma-themes-Kotonaru'
           'kotonaru-colors'
           'kde-kdm-themes-grey'
           'kdelibs-debug') 
pkg_source=("http://download.kde.org/stable/frameworks/5.15/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/kpty/commit/394eeff0dfba16de7418a25810edde66de541d61.diff")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         'ce96f4385235f0f6fa67702728a87e58')

do_prepare() {
    cd ${pkg_name}-${pkg_version}
    
    #patch -p1 -i ${CACHE_PATH}/394eeff0dfba16de7418a25810edde66de541d61.diff
}


do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
