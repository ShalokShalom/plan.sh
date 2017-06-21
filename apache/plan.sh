pkg_origin=cosmos

pkg_name=apache
pkg_version=2.4.26
pkg_description='A high performance Unix-based HTTP server'
pkg_upstream_url='https://www.apache.org/dist/httpd'
pkg_license=('Apache')
backup=(etc/httpd/conf/httpd.conf
        etc/httpd/conf/extra/httpd-{autoindex,dav,default,info,languages}.conf
        etc/httpd/conf/extra/httpd-{manual,mpm,multilang-errordoc}.conf
        etc/httpd/conf/extra/httpd-{ssl,userdir,vhosts}.conf
        etc/logrotate.d/httpd)
pkg_deps=('openssl' 'zlib' 'apr-util' 'pcre' 'systemd')
pkg_build_deps=('apr')
install=${pkg_name}.install
pkg_source=("https://www.apache.org/dist/httpd/httpd-${pkg_version}.tar.bz2"
        'httpd.logrotate'
        'kaos.layout'
        'httpd.service'
        'httpd-tmpfile.conf')
pkg_shasum=('d4d47749a44461cb2e6c9d78a22b522b'
         '6f0c3acecf1160fa6fb6970abce2d93b'
         '7511248625ccaaf3229a320167cdc5d9'
         '06abba73227c1cae7367207e3dacc5e2'
         '110a056408252de4356be7f53872b11d')

do_build() {

  # set default user
  sed -e 's#User daemon#User http#' \
      -e 's#Group daemon#Group http#' \
      -i docs/conf/httpd.conf.in 

  cat ${CACHE_PATH}/kaos.layout >> config.layout

    ${CACHE_PATH}/httpd-${pkg_version}/configure \
        --enable-layout=KaOS \
        --enable-mpms-shared=all \
        --enable-modules=all \
        --enable-mods-shared=all \
        --enable-so \
        --enable-suexec \
        --with-suexec-caller=http \
        --with-suexec-docroot=/srv/http \
        --with-suexec-logfile=/var/log/httpd/suexec.log \
        --with-suexec-bin=/usr/sbin/suexec \
        --with-suexec-uidmin=99 --with-suexec-gidmin=99 \
        --enable-ldap --enable-authnz-ldap \
        --enable-cache --enable-disk-cache --enable-mem-cache --enable-file-cache \
        --enable-ssl --with-ssl \
        --enable-deflate --enable-cgid \
        --enable-proxy --enable-proxy-connect \
        --enable-proxy-http --enable-proxy-ftp \
        --enable-dbd \
        --with-apr=/usr/bin/apr-1-config \
        --with-apr-util=/usr/bin/apu-1-config \
        --with-pcre=/usr 
        #--with-mpm="${mpm}"

    make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -D -m644 ${CACHE_PATH}/httpd.logrotate ${pkg_prefix}/etc/logrotate.d/httpd

  install -D -m644 ${CACHE_PATH}/httpd-tmpfile.conf ${pkg_prefix}/usr/lib/tmpfiles.d/httpd.conf
  install -d ${pkg_prefix}/usr/lib/systemd/system
  install -D -m644 ${CACHE_PATH}/httpd.service ${pkg_prefix}/usr/lib/systemd/system/
  
  install -D -m644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE

  ln -fs /usr/lib/httpd/modules ${pkg_prefix}/etc/httpd/modules

  # set defaults
  sed -e 's#/usr/lib/httpd/modules/#modules/#' \
	    -e 's|#\(LoadModule negotiation_module \)|\1|' \
	    -e 's|#\(LoadModule include_module \)|\1|' \
	    -e 's|#\(LoadModule userdir_module \)|\1|' \
	    -e 's|#\(LoadModule slotmem_shm_module \)|\1|' \
	    -e 's|#\(Include conf/extra/httpd-multilang-errordoc.conf\)|\1|' \
	    -e 's|#\(Include conf/extra/httpd-autoindex.conf\)|\1|' \
	    -e 's|#\(Include conf/extra/httpd-languages.conf\)|\1|' \
	    -e 's|#\(Include conf/extra/httpd-userdir.conf\)|\1|' \
	    -e 's|#\(Include conf/extra/httpd-default.conf\)|\1|' \
	    -e 's|#\(Include conf/extra/httpd-mpm.conf\)|\1|' \
	    -i ${pkg_prefix}/etc/httpd/conf/httpd.conf

  # cleanup
  rm -rf ${pkg_prefix}/usr/share/httpd/manual
  rm -rf ${pkg_prefix}/etc/httpd/conf/original
  rm -rf ${pkg_prefix}/srv/
  rm -rf ${pkg_prefix}/run
}
