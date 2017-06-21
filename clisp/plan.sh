pkg_origin=cosmos

pkg_name=clisp
pkg_version=2.49
pkg_description="ANSI Common Lisp interpreter, compiler and debugger"
pkg_license=('GPL')
pkg_upstream_url="http://clisp.cons.org/"
pkg_deps=('readline' 'libsigsegv')
pkg_build_deps=('ffcall')
pkg_source=("https://downloads.sourceforge.net/sourceforge/clisp/clisp-${pkg_version}.tar.bz2")
pkg_shasum=('1962b99d5e530390ec3829236d168649')

do_build() {
  sed -i 's|(:name "rl_readline_state") (:type int)|(:name "rl_readline_state") (:type ulong)|g' modules/readline/readline.lisp
  
  ./configure --prefix=/usr --with-readline --with-ffcall src
  
  ./makemake --prefix=/usr --with-readline --with-ffcall --with-dynamic-ffi > Makefile
  make 
  sed -i 's|http://www.lisp.org/HyperSpec/|http://www.lispworks.com/reference/HyperSpec/|g' config.lisp
  make 
}

do_package() {
  
  make DESTDIR=$pkg_prefix install 
}
