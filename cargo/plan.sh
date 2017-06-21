pkg_origin=cosmos

pkg_name=cargo
_pkg_name=cargo-nightly-x86_64-unknown-linux-gnu
pkg_version=0.18.0
pkg_description='Downloads your Rust project’s dependencies and compiles your project'
pkg_upstream_url='https://crates.io/install'
pkg_license=('MIT' 'Apache')
pkg_deps=('rust')
#pkg_source=("https://static.rust-lang.org/cargo-dist/${_pkg_name}.tar.gz")
pkg_source=("https://s3.amazonaws.com/rust-lang-ci/cargo-builds/6b05583d71f982bcad049b9fa094c637c062e751/${_pkg_name}.tar.gz")
pkg_shasum=('060023dd28b11b822de5b005d8e41005')

do_package() {
  
  install -Dm 0755 cargo/bin/cargo ${pkg_prefix}/usr/bin/cargo
  
  install -D -m644 cargo/etc/bash_completion.d/cargo $pkg_prefix/etc/bash_completion.d/cargo
  install -D -m644 cargo/share/zsh/site-functions/_cargo $pkg_prefix/usr/share/zsh/site-functions/_cargo
  install -D -m644 cargo/share/man/man1/cargo.1 $pkg_prefix/usr/share/man/man1/cargo.1

  install -Dm644 LICENSE-APACHE ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE-APACHE
  install -Dm644 LICENSE-MIT ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE-MIT
  install -Dm644 LICENSE-THIRD-PARTY ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE-THIRD-PARTY
} 
