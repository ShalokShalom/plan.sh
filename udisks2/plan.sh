pkg_origin=cosmos

pkg_name=udisks2
pkg_version=2.7.0
pkg_description="Disk Management Service"
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/udisks"
pkg_license=('GPL')
pkg_deps=('systemd' 'libgudev' 'sg3_utils' 'glib2' 'dbus-glib' 'polkit' 'parted' 'device-mapper'
         'libatasmart' 'lsof' 'lvm2' 'util-linux' 'libblockdev' 'gptfdisk')
pkg_build_deps=('intltool' 'docbook-xsl' 'python3')
pkg_source=("https://github.com/storaged-project/udisks/releases/download/udisks-${pkg_version}/udisks-${pkg_version}.tar.bz2"
        '10-enable-mount.rules')
pkg_shasum=('6f4bb56daca7be136f6eb4832ad2b3a0'
         '5f6c7dcbc2e98b7814a91fbe7630ecfc')

do_build() {
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --libexecdir=/usr/lib \
        --with-systemdsystemunitdir=/usr/lib/systemd/system \
        --disable-static \
        --enable-lvm2 \
        --enable-lvmcache \
        --enable-btrfs \
        --enable-zram \
        --enable-bcache
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
     bash_completiondir=/usr/share/bash-completion/completions
  
  # allow ntfs mounts
  sed -i -e 's|<allow_active>auth_admin_keep</allow_active>|<allow_active>yes</allow_active>|' ${CACHE_PATH}/usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy
  # set auto-mounting authorizations 
  install -dm 700 -o polkitd $CACHE_PATH/etc/polkit-1/rules.d/
  install -Dm 644 $CACHE_PATH/10-enable-mount.rules $CACHE_PATH/etc/polkit-1/rules.d/10-enable-mount.rules
}
