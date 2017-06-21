pkg_origin=

# create vbox-modules tar from the /VirtualBox-${_pkg_version}/out/linux.amd64/release/bin/src dir
# rename /src to vbox-kernel-module-src-${_pkg_version} and compress to tar.xz
# repeat for guest-modules from /VirtualBox-${_pkg_version}/out/linux.amd64/release/bin/additions/src

pkgbase=virtualbox-qt5
pkg_name=('virtualbox-qt5' 'virtualbox-guest-utils')
pkg_version=5.1.22
_pkg_version=5.1.22
pkg_upstream_url='http://virtualbox.org'
pkg_license=('GPL' 'custom')
pkg_build_deps=('alsa-lib' 'bin86' 'cdrkit' 'curl' 'device-mapper' 'glu' 'iasl' 'openjdk'
             'libidl2' 'libvncserver' 'libvpx' 'libxcomposite' 'libxcursor' 'libxinerama'
             'libxml2' 'libxmu' 'libxrandr' 'libxslt' 'libxtst' 'linux-headers' 'mesa' 'pulseaudio'
             'python2' 'qt5-tools' 'qt5-x11extras' 'sdl' 'sdl_ttf' 'xf86driproto' 
             'xf86-input-mouse' 'xorg-server')
pkg_source=("http://download.virtualbox.org/virtualbox/${pkg_version}/VirtualBox-${_pkg_version}.tar.bz2"
        '60-vboxdrv.rules'
        '60-vboxguest.rules'
        'LocalConfig.kmk'
        'vboxservice.service'
        'driver-path.patch'
        'include-path.patch')
pkg_shasum=('1e50a1fcf635e2f434b136f23bb60a82'
         '6e2722bfd7013c1b0174382626ac1b8d'
         'ed1341881437455d9735875ddf455fbe'
         'debd220f22dec74a8ae03126e4d3e678'
         '8ba9179c4a3516904417d773816dd992'
         '9be7e2703afeee1fca9368bd8750e710'
         '9e49bbaa2192b141c27ee43cef8cbab7')

do_prepare() {
    cd VirtualBox-${pkg_version}

    patch -p1 -i ${CACHE_PATH}/driver-path.patch
    patch -p1 -i ${CACHE_PATH}/include-path.patch
    
    sed -i -e 's|/usr/X11R6/bin/xterm|/usr/X11R6/bin/xterm|' src/VBox/Runtime/VBox/RTAssertShouldPanic-vbox.cpp
    sed -i -e 's|X11R6/||' configure
    sed -i -e 's|CXX_FLAGS=""|CXX_FLAGS="-std=c++11"|' configure
    sed -i -e 's|X11R6/||' Config.kmk
    sed -i -e 's|*&& check_makeself||' configure
    sed -i -e 's|smc-napa|smcnapa|' configure
    sed -i -e 's|$(filter-out vboxvideo_drv_%,$(DLLS)) vboxvideo_drv_system|$(filter-out vboxvideo_drv_%,$(DLLS))|' src/VBox/Additions/x11/vboxvideo/Makefile.kmk

    cp ${CACHE_PATH}/LocalConfig.kmk .

    echo "VBOX_GCC_OPT=$CXXFLAGS" >> LocalConfig.kmk
}

do_build() {
    cd VirtualBox-${pkg_version}

    ./configure \
        --disable-docs \
        --disable-kmods \
        --disable-vmmraw \
        --enable-pulse \
        --nofatal \
        --enable-qt5

    source ./env.sh
    kmk all
}

package_virtualbox-qt5() {
    pkg_description='Oracle VM VirtualBox is powerful x86 virtualization for enterprise as well as home use'
    pkg_deps=('glibc' 'openssl' 'curl' 'gcc-libs' 'libpng' 'python2' 'sdl'
             'libvpx' 'libxml2' 'procps-ng' 'shared-mime-info' 'zlib'
             'libxcursor' 'libxinerama' 'libx11' 'libxext' 'libxmu' 'libxt' 'xf86-input-mouse'
             'qt5-x11extras' 'virtualbox-modules')
    optpkg_deps=('virtualbox-guest-iso: Guest Additions CD image'
                'virtualbox-ext-oracle: for Oracle extensions'
                'net-tools: Host-only or bridged networking support')
    conflicts=('virtualbox')
    replaces=('virtualbox')
    provides=('virtualbox')
    backup=('etc/vbox/vbox.cfg')
    install=virtualbox.install

    source VirtualBox-${pkg_version}/env.sh
    cd VirtualBox-${pkg_version}/out/linux.amd64/release/bin

    # binaries
    install -dm755 ${pkg_prefix}/usr/bin
    install -m755 VBox.sh ${pkg_prefix}/usr/bin/VBox
    for i in VBoxHeadless VBoxManage VBoxSDL VirtualBox VBoxBalloonCtrl; do
        ln -sf VBox ${pkg_prefix}/usr/bin/$i
        ln -sf VBox ${pkg_prefix}/usr/bin/${i,,}
    done
    install -m755 VBoxTunctl ${pkg_prefix}/usr/bin

    # libraries
    install -dm755 ${pkg_prefix}/usr/lib/virtualbox
    install -m755 *.so ${pkg_prefix}/usr/lib/virtualbox
    install -m644 *.r0 VBoxEFI*.fd ${pkg_prefix}/usr/lib/virtualbox
    ## setuid root binaries
    install -m4755 VBoxSDL VirtualBox VBoxHeadless VBoxNetDHCP VBoxNetAdpCtl VBoxNetNAT -t ${pkg_prefix}/usr/lib/virtualbox
    ## other binaries
    install -m755 VBoxManage VBoxSVC VBoxExtPackHelperApp VBoxXPCOMIPCD VBoxTestOGL VBoxBalloonCtrl -t ${pkg_prefix}/usr/lib/virtualbox

    # components
    install -dm755 ${pkg_prefix}/usr/lib/virtualbox/components
    install -m755 components/* -t ${pkg_prefix}/usr/lib/virtualbox/components

    # extensions packs, disable for now, experimental according to ExtPack.xml
    #install -dm755 ${pkg_prefix}/usr/lib/virtualbox/ExtensionPacks
    #install -m755 ExtensionPacks/* -t ${pkg_prefix}/usr/lib/virtualbox/ExtensionPacks

    # languages
    install -dm755 ${pkg_prefix}/usr/share/virtualbox/nls
    install -m755 nls/*.qm -t ${pkg_prefix}/usr/share/virtualbox/nls

    # scripts
    install -m755 VBoxCreateUSBNode.sh VBoxSysInfo.sh -t ${pkg_prefix}/usr/share/virtualbox

    # icons
    install -Dm644 VBox.png ${pkg_prefix}/usr/share/pixmaps/VBox.png

    pushd icons >/dev/null
    for i in *; do
        install -d ${pkg_prefix}/usr/share/icons/hicolor/$i/mimetypes
        cp $i/* ${pkg_prefix}/usr/share/icons/hicolor/$i/mimetypes
    done
    popd >/dev/null

    #desktop
    install -Dm644 virtualbox.desktop ${pkg_prefix}/usr/share/applications/virtualbox.desktop
    install -Dm644 virtualbox.xml ${pkg_prefix}/usr/share/mime/packages/virtualbox.xml

    #install configuration files
    install -dm755 ${pkg_prefix}/etc/vbox
    echo 'INSTALL_DIR=/usr/lib/virtualbox' > ${pkg_prefix}/etc/vbox/vbox.cfg
    install -dm755 ${pkg_prefix}/etc/ld.so.conf.d
    echo '/usr/lib/virtualbox' > ${pkg_prefix}/etc/ld.so.conf.d/virtualbox.conf

    cd ${CACHE_PATH}

    install -Dm644 VirtualBox-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE

    # systemd
    install -Dm644 60-vboxdrv.rules ${pkg_prefix}/usr/lib/udev/rules.d/60-vboxdrv.rules
}
    
package_virtualbox-guest-utils() {
    pkg_description='Oracle VM VirtualBox Guest userspace utilities'
    pkg_deps=('glibc' 'pam' 'libx11' 'libxcomposite' 'libxdamage' 'libxext' 'libxfixes' 
             'libxmu' 'libxt' 'xorg-server-utils' 'virtualbox-guest-modules')
    install=virtualbox-guest-utils.install

    source VirtualBox-${pkg_version}/env.sh
    
    pushd VirtualBox-${pkg_version}/out/linux.amd64/release/bin/additions
    install -d ${pkg_prefix}/usr/bin
    install -m755 VBoxClient VBoxControl VBoxService mount.vboxsf ${pkg_prefix}/usr/bin
    install -m755 -D ${CACHE_PATH}/VirtualBox-${pkg_version}/src/VBox/Additions/x11/Installer/98vboxadd-xclient \
        ${pkg_prefix}/usr/bin/VBoxClient-all
    install -m755 -D ${CACHE_PATH}/VirtualBox-${pkg_version}/src/VBox/Additions/x11/Installer/vboxclient.desktop \
        ${pkg_prefix}/etc/xdg/autostart/vboxclient.desktop
    #install -D vboxvideo_drv_system.so ${pkg_prefix}/usr/lib/xorg/modules/drivers/vboxvideo.so
    install -d ${pkg_prefix}/usr/lib/xorg/modules/dri
    install -m755 VBoxOGL*.so ${pkg_prefix}/usr/lib
    ln -s /usr/lib/VBoxOGL.so ${pkg_prefix}/usr/lib/xorg/modules/dri/vboxvideo_dri.so
    install -m755 -D pam_vbox.so ${pkg_prefix}/usr/lib/security/pam_vbox.so
    popd
 
    install -Dm644 60-vboxguest.rules ${pkg_prefix}/usr/lib/udev/rules.d/60-vboxguest.rules
    install -Dm644 vboxservice.service ${pkg_prefix}/usr/lib/systemd/system/vboxservice.service

    install -Dm644 VirtualBox-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE
}


