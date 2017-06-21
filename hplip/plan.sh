pkg_origin=cosmos

pkg_name=hplip
pkg_version=3.17.6
# incase a or b is used in hplip rls:
_pkg_version=3.17.6
pkg_description="Drivers for HP DeskJet, OfficeJet, Photosmart, Business Inkjet and some LaserJet."
pkg_upstream_url="http://hplipopensource.com"
pkg_license=('GPL')
pkg_deps=('ghostscript' 'foomatic-db' 'foomatic-db-engine' 'cups'
         'net-snmp' 'libusb' 'wget' 'python3-gobject3' 'pyqt5-python3')
pkg_build_deps=('pkgconfig' 'sane' 'rpcbind' 'dbus-python3')
pkg_deps=('dbus-python3: for dbus support'
            'sane: for scanner support'
            'rpcbind: for network support')
install=${pkg_name}.install
pkg_source=("https://downloads.sourceforge.net/hplip/${pkg_name}-${_pkg_version}.tar.gz"
        "https://launchpadlibrarian.net/281975878/patch"
        'cups-2.2.patch')
pkg_shasum=('12aea2af77b4c609ba524c3203e5a6df'
         'c873eb40c9e3fa794637523400190218'
         'ceb7449b12e2ecf70f898bc50b161a3c')

do_build() {
  find . -type f -exec sed -i 's~^#.*env python~#!/usr/bin/env python3~' {} +
  sed -i '1s|#!/usr/bin/python|#!/usr/bin/python3|' doctor.py setup.py makeuri.py logcapture.py base/magic.py
  sed -i '1s|#!/usr/bin/python|#!/usr/bin/python3|' ui/upgradeform.py uninstall.py upgrade.py config_usb_printer.py
  sed -i 's|python ./print.py|python3 ./print.py|' scan.py
  sed -i 's|python ./testpage.py|python3 ./testpage.py|' setup.py
  sed -i 's|python %HOME%|python3 %HOME%|' base/utils.py
  sed -i 's|python ./plugin.py|python3 ./plugin.py|' base/pkit.py
  sed -i 's|/usr/bin/python|/usr/bin/python3|' data/rules/hplip-printer@.service
  # https://github.com/KaOSx/main/issues/31, patch file prnt/filters/hpps
  #patch -p2 -i ${CACHE_PATH}/patch
  # cups 2.2 patch https://packages.debian.org/sid/hplip
  patch -p1 -i ${CACHE_PATH}/cups-2.2.patch

  # from Gentoo
  # Use system foomatic-rip for hpijs driver instead of foomatic-rip-hplip
  # move to cups-filters version asap http://hplipopensource.com/hplip-web/install/manual/distros/lfs.html
  local i
  for i in ppd/hpijs/*.ppd.gz ; do
    rm -f ${i}.temp
    gunzip -c ${i} | sed 's/foomatic-rip-hplip/foomatic-rip/g' | \
    gzip > ${i}.temp || return 1
    mv ${i}.temp ${i}
  done

  export AUTOMAKE='automake --foreign'
  export PYTHON=/usr/bin/python3
  autoreconf --force --install

	./configure --prefix=/usr \
             --disable-qt4 \
             --enable-qt5 \
             --disable-foomatic-rip-hplip-install \
             --enable-foomatic-ppd-install \
             --enable-hpcups-install \
             --enable-new-hpcups \
             --enable-cups-ppd-install \
             --enable-cups-drv-install \
             --enable-hpijs-install \
             --enable-foomatic-drv-install \
             --enable-pp-build 
  make 
}

do_package() {

  make rulesdir=/usr/lib/udev/rules.d DESTDIR=${pkg_prefix}/ install

  # remove sane conflicts and obsolete files
  rm -rf ${pkg_prefix}/etc/{sane.d,xdg}
  rm -vrf ${pkg_prefix}/usr/share/hal
  rm -vrf $pkg_prefix/etc/init.d
}
