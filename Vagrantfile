# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"
  config.vm.provider "vmware_fusion" do |v|
    v.gui = true
    v.vmx["memsize"] = "4096"
    v.vmx["numvcpus"] = "6"
  end
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
set -e
apt-get update
apt-get install -y software-properties-common
add-apt-repository -y ppa:hvr/ghc
apt-get update
apt-get install -y cabal-install-1.20 ghc-7.10.1 happy-1.19.5 alex-3.1.4
apt-get install -y git mercurial g++ gcc git autoconf ncurses-dev automake libtool make python bzip2
hg clone https://bitbucket.org/GregorR/musl-cross /tmp/musl-cross
cd /tmp/musl-cross
echo "GCC_BUILTIN_PREREQS=yes" >> config.sh
echo "ARCH=x86_64" >> config.sh
time ./build.sh > /dev/null 2>&1
export PATH=/opt/cross/x86_64-linux-musl/bin:/opt/ghc/7.10.1/bin:/opt/happy/1.19.5/bin:/opt/alex/3.1.4/bin:${PATH}
cd /tmp
curl -O http://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
gunzip -c /tmp/ncurses*.gz | tar xf -
cd /tmp/ncurses-5.9
# musl not recognized by default configure script, so take over the uclibc triples
perl -pi -e 's/linux\-uclibc/linux\-musl/g' config.sub
./configure --target=x86_64-linux-musl --with-gcc=x86_64-linux-musl-gcc --with-shared --host=x86_64-linux-musl --with-build-cpp=x86_64-linux-musl-g++ --prefix=/opt/cross/x86_64-linux-musl
make
make install
git config --global url."git://github.com/ghc/packages-".insteadOf git://github.com/ghc/packages/
git clone -b ghc-7.10.1-release --recursive git://git.haskell.org/ghc.git /tmp/ghc
cd /tmp/ghc
cp /tmp/ghc/mk/build.mk.sample /tmp/ghc/mk/build.mk
echo "INTEGER_LIBRARY = integer-simple" >> /tmp/ghc/mk/build.mk
echo "Stage1Only = YES" >> /tmp/ghc/mk/build.mk
perl boot
./configure --target=x86_64-linux-musl --with-curses-includes=/opt/cross/x86_64-linux-musl/include/ncurses --with-curses-libraries=/opt/cross/x86_64-linux-musl/lib
make
SHELL
end
