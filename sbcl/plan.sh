pkg_origin=cosmos

# rebuild maxima on updates
pkg_name=sbcl
pkg_version=1.3.18
pkg_description="Steel Bank Common Lisp"
pkg_upstream_url="http://www.sbcl.org/"
pkg_license=('custom')
pkg_deps=('glibc' 'zlib')
pkg_build_deps=('sbcl')
pkg_source=("https://downloads.sourceforge.net/project/sbcl/sbcl/${pkg_version}/${pkg_name}-${pkg_version}-source.tar.bz2"
        'fixes.lisp')
pkg_shasum=('b2271afe0bc390db349d20640430a000'
         '7ac0c1936547f4278198b8bf7725204d')

do_build() {

  export CFLAGS+=" -D_GNU_SOURCE -fno-omit-frame-pointer -DSBCL_HOME=/usr/lib/sbcl"
  export GNUMAKE="make"

  export LINKFLAGS="$LDFLAGS"
  unset LDFLAGS
  unset MAKEFLAGS

  cat >customize-target-features.lisp <<EOF
(lambda (features)
  (flet ((enable (x) (pushnew x features))
         (disable (x) (setf features (remove x features))))
  (enable :sb-thread)
  (enable :sb-core-compression)
  (disable :largefile)))
EOF

  sh make.sh sbcl --prefix=/usr
  make -C doc/manual info
}

do_package() {
  SBCL_HOME="" INSTALL_ROOT=$CACHE_PATH/usr sh install.sh

  src/runtime/sbcl --core output/sbcl.core --script ${CACHE_PATH}/fixes.lisp
  mv sbcl-new.core ${CACHE_PATH}/usr/lib/sbcl/sbcl.core

  mkdir -p ${CACHE_PATH}/usr/share/sbcl-source
  cp -R -t ${CACHE_PATH}/usr/share/sbcl-source ${CACHE_PATH}/${pkg_name}-${pkg_version}/{src,contrib}

  install -D -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/license.txt

  find ${CACHE_PATH} \( -name Makefile -o -name .cvsignore \) -delete
  find ${CACHE_PATH}/usr/share/sbcl-source -type f \
    \( -name \*.fasl -o -name \*.o -o -name \*.log -o -name \*.so -o -name a.out \) -delete

  rm ${CACHE_PATH}/usr/share/sbcl-source/src/runtime/sbcl{,.nm}

}
