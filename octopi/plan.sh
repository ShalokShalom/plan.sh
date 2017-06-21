pkg_origin=

pkg_name=octopi
pkg_version=0.8.113
_commit=23623f9cee62a0e723dcc3e64e378c022d720a7b
pkg_description="This is Octopi, a powerful Pacman frontend using Qt libs"
pkg_upstream_url="https://octopiproject.wordpress.com/"
pkg_license=('GPL2')
pkg_deps=('pacman' 'pkgfile' 'knotifications' 'gist' 'alpm_octopi_utils')
#install=octopi.install
pkg_source=("https://github.com/aarnt/octopi/archive/${_commit}.zip"
        "images2.tar.xz")
pkg_shasum=('2baf633f093ac2da1e89bd166a150ed3'
         '858db0982326bcbc77526a7945d35bc7')

do_prepare() {
   cd ${pkg_name}-${_commit}/
   rm -r resources/images
   mv -iv ${CACHE_PATH}/images/ resources/
   cp resources/images/octopi_green.png resources/images/octopi.png

   # enable the kstatus switch
   sed -e "s|#KSTATUS|KSTATUS|" -i notifier/octopi-notifier/octopi-notifier.pro
   
   sed -e "s|pacman -U --force|pacman -U|" -i src/pacmanexec.cpp
   #patch -p1 -i ${CACHE_PATH}/log2.diff
   #sed -e "s|return p.readAllStandardOutput();|return p.toLatin1();|" -i src/unixcommand.cpp
}
         
do_build() {
   cd ${pkg_name}-${_commit}
   
   /usr/lib/qt5/bin/qmake octopi.pro
   make
   
   cd notifier/pacmanhelper
   /usr/lib/qt5/bin/qmake pacmanhelper.pro
   make
   cd ../..
   
   cd notifier/octopi-notifier
   /usr/lib/qt5/bin/qmake octopi-notifier.pro
   make
   cd ../..
   
   cd cachecleaner
   /usr/lib/qt5/bin/qmake octopi-cachecleaner.pro
   make
}

do_package() {
   cd ${pkg_name}-${_commit}
   make INSTALL_ROOT=${pkg_prefix} install
   
   cd notifier/pacmanhelper
   make INSTALL_ROOT=${pkg_prefix} install
   cd ../..
   
   cd notifier/octopi-notifier
   make INSTALL_ROOT=${pkg_prefix} install
   cd ../..
   
   cd cachecleaner
   make INSTALL_ROOT=${pkg_prefix} install
}
