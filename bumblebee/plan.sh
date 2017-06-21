pkg_origin=cosmos

pkg_name=bumblebee
pkg_version=3.2.1
pkg_description="Bumblebee brings Optimus Support for Linux Through VirtualGL."
pkg_upstream_url="http://www.Bumblebee-Project.org"
pkg_license=("GPL3")
pkg_deps=('virtualgl' 'glib2')
pkg_build_deps=('help2man')
pkg_deps=('xf86-video-nouveau: Nouveau driver' 
            'bbswitch: switch on/off discrete card'
            'nvidia-utils-bumblebee: Nvidia utils not breaking LibGL'
            'nvidia-bumblebee: Nvidia kernel driver')
install='bumblebee.install'
backup=('etc/bumblebee/bumblebee.conf'
        'etc/bumblebee/xorg.conf.nouveau'
        'etc/bumblebee/xorg.conf.nvidia')
pkg_source=("http://www.bumblebee-project.org/${pkg_name}-${pkg_version}.tar.gz"
        'bumblebee.conf')
pkg_shasum=('30974e677bb13e8a3825fd6f3e7d3b24'
         '43c2c5c069ac8628bd86cd5865785639')

do_build() {
    ./configure \
        CONF_DRIVER_MODULE_NVIDIA=nvidia \
        CONF_LDPATH_NVIDIA=/usr/lib/nvidia \
        CONF_MODPATH_NVIDIA=/usr/lib/nvidia/xorg/,/usr/lib/xorg/modules \
        --prefix=/usr \
        --with-udev-rules=/usr/lib/udev/rules.d \
        --without-pidfile \
        --sysconfdir=/etc
    make
}

do_package() {
    make install DESTDIR=${pkg_prefix}
  
    install -D -m644 scripts/systemd/bumblebeed.service ${pkg_prefix}/usr/lib/systemd/system/bumblebeed.service
    mv -v ${pkg_prefix}/etc/bash_completion.d/bumblebee ${pkg_prefix}/etc/bash_completion.d/optirun
    # upstream recommended blacklisting
    install -D -m644 ${CACHE_PATH}/bumblebee.conf ${pkg_prefix}/etc/modprobe.d/bumblebee.conf
}
