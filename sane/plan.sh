pkg_origin=cosmos

pkg_name=sane
pkg_version=1.0.27
pkg_description="Application programming interface (API) that provides standardized access to any raster image scanner hardware."
pkg_upstream_url="http://www.sane-project.org"
pkg_license=('GPL')
pkg_deps=('libtiff' 'libgphoto2' 'libjpeg-turbo' 'libieee1284' 'libusb'
         'v4l-utils' 'avahi' 'bash' 'net-snmp' 'libcups')
pkg_build_deps=('texlive-latexextra')
backup=(etc/sane.d/{abaton.conf,agfafocus.conf,apple.conf,artec.conf,artec_eplus48u.conf,avision.conf,bh.conf,canon.conf,canon630u.conf,canon_dr.conf,canon_pp.conf,cardscan.conf,coolscan2.conf,coolscan3.conf,coolscan.conf,dc25.conf,dc210.conf,dc240.conf,dell1600n_net.conf,dll.conf,dmc.conf,epjitsu.conf,epson.conf,epson2.conf,fujitsu.conf,genesys.conf,gphoto2.conf,gt68xx.conf,hp.conf,hp3900.conf,hp4200.conf,hp5400.conf,hpsj5s.conf,hs2p.conf,ibm.conf,kodak.conf,leo.conf,lexmark.conf,ma1509.conf,magicolor.conf,matsushita.conf,microtek.conf,microtek2.conf,mustek.conf,mustek_pp.conf,mustek_usb.conf,mustek_usb2.conf,nec.conf,net.conf,p5.conf,pie.conf,pixma.conf,plustek.conf,plustek_pp.conf,qcam.conf,ricoh.conf,rts8891.conf,s9036.conf,saned.conf,sceptre.conf,sharp.conf,sm3840.conf,snapscan.conf,sp15c.conf,st400.conf,stv680.conf,tamarack.conf,teco1.conf,teco2.conf,teco3.conf,test.conf,u12.conf,umax.conf,umax1220u.conf,umax_pp.conf,xerox_mfp.conf,v4l.conf} 
etc/xinetd.d/sane)
# download version 1-3, create tar with:  cat sane-backends-1.0.23.tar.gz.[1-3] > sane-backends-1.0.23.tar.gz
pkg_source=("https://alioth.debian.org/frs/download.php/file/4224/${pkg_name}-backends-${pkg_version}.tar.gz"
        #ftp://ftp2.sane-project.org/pub/sane/$pkg_name-backends-$pkg_version/$pkg_name-backends-$pkg_version.tar.gz
        'sane.xinetd'
        'saned.socket'
        'saned.service')
pkg_shasum=('b10a08785f92a4c07ad961f4d843c934'
         '5f519030392d599e2ad348159ec4c96f'
         'e57e9e15528f47f5f1b3f1411135ed5d'
         'e44bd4c994a52d6f472463d1eb0a03be')

do_build() {
  # http://kaosx.us/phpBB3/viewtopic.php?f=10&t=46&p=210#p208
  #patch -p1 -i ${CACHE_PATH}/avahi.patch

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --enable-avahi \
    --enable-pthread \
    --disable-rpath \
    --disable-locking \
    --with-usb
  make
}

package () {
  make DESTDIR=${CACHE_PATH} install

  echo "#hpaio" >> ${CACHE_PATH}/etc/sane.d/dll.conf

  install -D -m0644 tools/udev/libsane.rules ${CACHE_PATH}/usr/lib/udev/rules.d/53-sane.rules
  sed -i 's|NAME="%k", ||g' ${CACHE_PATH}/usr/lib/udev/rules.d/53-sane.rules
  
  install -D -m644 ${CACHE_PATH}/sane.xinetd ${CACHE_PATH}/etc/xinetd.d/sane

  install -D -m644 tools/sane-backends.pc ${CACHE_PATH}/usr/lib/pkgconfig/sane-backends.pc

  install -D -m644 ${CACHE_PATH}/saned.socket ${CACHE_PATH}/usr/lib/systemd/system/saned.socket
  install -D -m644 ${CACHE_PATH}/saned.service ${CACHE_PATH}/usr/lib/systemd/system/saned@.service
}
