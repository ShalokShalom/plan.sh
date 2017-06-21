pkg_origin=cosmos

pkg_name=usbutils
pkg_version=008
pkg_description="USB Device Utilities"
pkg_license=('GPL')
pkg_deps=('libusb' 'hwids')
optpkg_deps=('python2: for lsusb.py usage'
            'coreutils: for lsusb.py usage'
            'wget: for update-usbids.sh usage')
pkg_upstream_url="http://linux-usb.sourceforge.net/"
pkg_source=("https://www.kernel.org/pub/linux/utils/usb/usbutils/${pkg_name}-${pkg_version}.tar.xz"
        'fix-python2.patch')
pkg_shasum=('2780b6ae21264c888f8f30fb2aab1259'
         '45766196895b4cc50b53cd56e1bbf3d1')

do_build() {
  cd $pkg_name-$pkg_version
  patch -p1 -i $CACHE_PATH/fix-python2.patch
  
  ./configure --prefix=/usr --datadir=/usr/share/hwdata --disable-zlib
  make
}

do_package() {
  cd $pkg_name-$pkg_version
  make DESTDIR=$pkg_prefix install
  
  # part of hwids 
  rm -rf $pkg_prefix/usr/{share/hwdata,sbin}
}

