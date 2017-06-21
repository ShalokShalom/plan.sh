pkg_origin=cosmos

pkg_name=udisks
pkg_version=1.0.5
pkg_description="Disk Management Service"
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/udisks"
pkg_license=('GPL')
pkg_deps=('systemd' 'libgudev' 'sg3_utils' 'glib2' 'dbus-glib' 'polkit' 'parted' 'device-mapper'
         'libatasmart' 'lsof' 'lvm2' 'util-linux')
pkg_build_deps=('intltool' 'docbook-xsl')
#install=udisks.install
pkg_source=("http://hal.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.gz"
	'drop-pci-db.patch')
pkg_shasum=('70d48dcfe523a74cd7c7fbbc2847fcdd'
         '2746c65d0d12fcc6a550b5a8d9085ab2')

do_build() {
  sed -i '1i #include <sys/stat.h>' src/helpers/job-drive-detach.c
  
  # fix fail pci-db message, patch thanks to Tom Gundersen <teg@jklm.no>
  patch -p1 -i ${CACHE_PATH}/drop-pci-db.patch
  
  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --libexecdir=/usr/lib/udisks \
      --disable-static

  make
}

do_package() {
  make profiledir=/usr/share/bash-completion/completions DESTDIR="${CACHE_PATH}" install
  chmod 644 "${CACHE_PATH}/usr/share/bash-completion/completions/udisks-bash-completion.sh"
  # move udev helpers and rules to /usr/lib
  mv "${CACHE_PATH}"/lib/udev "${CACHE_PATH}"/usr/lib/
  rm -r "${CACHE_PATH}"/lib
  
  #fix ntfs mounts
  sed -i -e 's|<allow_active>auth_admin_keep</allow_active>|<allow_active>yes</allow_active>|' ${CACHE_PATH}/usr/share/polkit-1/actions/org.freedesktop.udisks.policy
}
