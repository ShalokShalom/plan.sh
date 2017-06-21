pkg_origin=cosmos
 
pkg_name=lpsolve
_pkg_name=lp_solve
pkg_version=5.5.2.5
_pkg_version=5.5
pkg_description="Mixed Integer Linear Programming (MILP) solver"
pkg_upstream_url="http://lpsolve.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/project/lpsolve/lpsolve/${pkg_version}/${_pkg_name}_${pkg_version}_source.tar.gz"
        'cflags.patch')
pkg_shasum=('3be57261fc41dd8e210f54017220d5f7'
         '7403f745d06619f59f52800b655d8751')

do_build() {
  patch -p1 -i $CACHE_PATH/cflags.patch
  # fix for current gcc/glibc
  sed -i -e 's|isnan(0)|isnan(0.0)|' lpsolve55/ccc
  sed -i -e 's|isnan(0)|isnan(0.0)|' lp_solve/ccc

  sh -x ccc
  #rm bin/ux*/liblpsolve55.a
  sh -x ccc
}

do_package() {

 install -d ${pkg_prefix}/usr/{bin,lib,include/lpsolve}
 install -m 755 lp_solve/bin/ux*/lp_solve ${pkg_prefix}/usr/bin/
 install -m 755 lpsolve55/bin/ux*/liblpsolve55.so ${pkg_prefix}/usr/lib/
 install -m 644 lp*.h ${pkg_prefix}/usr/include/lpsolve/
}
