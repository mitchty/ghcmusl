# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "phusion/ubuntu-12.04-amd64"
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
apt-get update
apt-get install -y ppa:hvr/ghc
apt-get update
apt-get install -y cabal-install 1.20 ghc-7.8.4
curl -L http://mirrors.gigenet.com/alpinelinux/v3.2/main/x86_64/apk-tools-static-2.6.0-r0.apk -o /tmp/apk-tools-static-2.6.0-r0.apk
mkdir -p /tmp/alpine-chroot /tmp/bs
tar -xzf /tmp/apk-tools-static-2.6.0-r0.apk -C /tmp/bs
/tmp/bs/sbin/apk.static -X http://mirrors.gigenet.com/alpinelinux/v3.2/main -U --allow-untrusted --root /tmp/alpine-chroot --initdb add alpine-base
mkdir -p /tmp/alpine-chroot/etc/apk
echo "http://mirrors.gigenet.com/alpinelinux/v3.2/main" > /tmp/alpine-chroot/etc/apk/repositories
echo 'nameserver 8.8.8.8' > /tmp/alpine-chroot/etc/resolv.conf
mount --bind /dev /tmp/alpine-chroot/dev
mount --bind /sys /tmp/alpine-chroot/sys
mount --bind /proc /tmp/alpine-chroot/proc
chroot /tmp/alpine-chroot rc-update add devfs sysinit
chroot /tmp/alpine-chroot rc-update add dmesg sysinit
chroot /tmp/alpine-chroot rc-update add mdev sysinit

chroot /tmp/alpine-chroot rc-update add hwclock boot
chroot /tmp/alpine-chroot rc-update add modules boot
chroot /tmp/alpine-chroot rc-update add sysctl boot
chroot /tmp/alpine-chroot rc-update add hostname boot
chroot /tmp/alpine-chroot rc-update add bootmisc boot
chroot /tmp/alpine-chroot rc-update add syslog boot

chroot /tmp/alpine-chroot rc-update add mount-ro shutdown
chroot /tmp/alpine-chroot rc-update add killprocs shutdown
chroot /tmp/alpine-chroot rc-update add savecache shutdown
chroot /tmp/alpine-chroot apk update
chroot /tmp/alpine-chroot apk add alpine-sdk
  SHELL
end
