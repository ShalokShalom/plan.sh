pkg_origin=cosmos

pkg_name=lm_sensors
pkg_version=3.4.0
pkg_description="Collection of user space tools for general SMBus access and hardware monitoring"
pkg_upstream_url="https://github.com/groeck/lm-sensors"
pkg_license=('GPL' 'LGPL')
pkg_deps=('perl' 'sysfsutils')
pkg_build_deps=('rrdtool')
backup=('etc/sensors3.conf' 'etc/conf.d/healthd' 'etc/conf.d/sensord')
pkg_source=("http://pkgs.fedoraproject.org/repo/pkgs/lm_sensors/lm_sensors-3.4.0.tar.bz2/c03675ae9d43d60322110c679416901a/lm_sensors-${pkg_version}.tar.bz2" 
        'healthd' 
        'healthd.conf' 
        'sensord.conf' 
        'healthd.service')
pkg_shasum=('c03675ae9d43d60322110c679416901a'
         'b68bdb73bb4d28ebdb36e2d92278582d'
         'f3ed015c38bdbe9b4e17d38833fde9cc'
         'd398a55842fb5f2365a011512df6fc3c'
         'daf19e142d59f015040814172742502b')

do_build() {
  sed -i 's|/etc/sysconfig|/etc/conf.d|' prog/{detect/sensors-detect,init/lm_sensors.service}
  sed -i 's/EnvironmentFile=/EnvironmentFile=-/' prog/init/lm_sensors.service
  
  make PREFIX=/usr
}

do_package() {
  make BUILD_STATIC_LIB=0 \
    PREFIX=/usr MANDIR=/usr/share/man DESTDIR=${pkg_prefix} install
    
  install -D -m644 prog/init/fancontrol.service ${pkg_prefix}/usr/lib/systemd/system/fancontrol.service
  install -D -m644 prog/init/lm_sensors.service ${pkg_prefix}/usr/lib/systemd/system/lm_sensors.service
  
  install -D -m755 ${CACHE_PATH}/healthd ${pkg_prefix}/usr/sbin/healthd
  install -D -m644 ${CACHE_PATH}/healthd.conf ${pkg_prefix}/etc/conf.d/healthd
  install -D -m644 ${CACHE_PATH}/sensord.conf ${pkg_prefix}/etc/conf.d/sensord
  install -D -m644 ${CACHE_PATH}/healthd.service ${pkg_prefix}/usr/lib/systemd/system/healthd.service
}
