FROM uggedal/alpine
MAINTAINER mitchty

# Install archlinux in a chroot first
WORKDIR /

RUN apk update

RUN apk add bash wget xz sed gawk tar gzip grep

ADD https://raw.github.com/tokland/arch-bootstrap/master/arch-bootstrap.sh /usr/bin/arch-bootstrap

RUN chmod 755 /usr/bin/arch-bootstrap

RUN mkdir /archchroot

RUN bash /usr/bin/arch-bootstrap -a x86_64 /archchroot

RUN chroot /archchroot pacman-key --init

RUN chroot /archchroot pacman-key --populate archlinux

RUN chroot /archchroot pacman -Syyu || /bin/true

RUN chroot /archchroot pacman -Rs systemd || /bin/true

RUN chroot /archchroot pacman -S sudo || /bin/true

RUN chroot /archchroot pacman -S less licenses man-db man-pages procps-ng psmisc sysfsutils base-devel openssh cpio elfutils rsync unzip vim wget zip || /bin/true

# ADD start-chroot /usr/bin/start-chroot

# RUN chmod 755 /usr/bin/start-chroot

# RUN /usr/bin/start-chroot /archchroot

RUN apk add paxctl libedit-dev libiconv-dev gmp-dev

RUN mkdir -p /alien

RUN ln -s
