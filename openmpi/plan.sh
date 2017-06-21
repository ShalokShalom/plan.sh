pkg_origin=cosmos

pkg_name=openmpi
pkg_version=2.1.1
_pkg_version=2.1
pkg_description="High performance message passing library (MPI)"
pkg_upstream_url="https://www.open-mpi.org"
pkg_license=('custom')
pkg_deps=('gcc' 'openssh' 'valgrind' 'libltdl' 'hwloc')
pkg_build_deps=('inetutils')
pkg_source=("https://www.open-mpi.org/software/ompi/v${_pkg_version}/downloads/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('ae542f5cf013943ffbbeb93df883731b')

do_build() {

   ./configure --prefix=/usr \
        --sysconfdir=/etc/${pkg_name} \
        --mandir=/usr/share/man \
        --enable-mpi-fortran=all \
        --libdir=/usr/lib/${pkg_name} \
        --enable-mpi-cxx \
        --enable-builtin-atomics \
        --enable-mpi-thread-multiple \
        --with-valgrind \
        --enable-memchecker \
        --enable-debug \
        --enable-pretty-print-stacktrace \
        --without-slurm \
        --with-hwloc=/usr \
        --with-libltdl=/usr \
        FC=/usr/bin/gfortran \
        LDFLAGS="$LDFLAGS -Wl,-z,noexecstack"

   make
}

do_package() {
   make DESTDIR=${pkg_prefix} install

   install -d -m 755 ${pkg_prefix}/usr/lib/pkgconfig
   for i in ompi-c.pc ompi-cxx.pc ompi-f77.pc ompi-f90.pc ompi.pc; do
      ln -sf /usr/lib/openmpi/pkgconfig/$i ${pkg_prefix}/usr/lib/pkgconfig/
   done

   install -d -m 755 ${pkg_prefix}/etc/ld.so.conf.d
   echo /usr/lib/${pkg_name} > ${pkg_prefix}/etc/ld.so.conf.d/${pkg_name}.conf

   install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
