FROM archlinux:latest

# RUN echo 'Server = https://mirrors.sustech.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

RUN pacman --noconfirm -Sy archlinux-keyring && \
    pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Su --noconfirm && \
    pacman -S --noconfirm wget vim xorg adobe-source-han-sans-cn-fonts noto-fonts-emoji git fakeroot binutils nss libxss gtk3 alsa-lib pulseaudio gjs libappindicator-gtk3 fcitx5-gtk xdg-utils libvips openjpeg2 && \
    pacman -Scc --noconfirm

# ARG USER_ID
# ARG TIMEZONE

RUN env && useradd -m user 
# RUN ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

USER user
RUN ["/bin/bash", "-c", "wget -qO- -t1 -T2 \"https://api.github.com/repos/super-moe/linuxqq/releases/latest\" | grep \"browser_download_url\" | sed -r -n 's/.*\"browser_download_url\": *\"(.*)\".*/\\1/p' | xargs wget -O ~/linuxqq.pkg.tar.zst"]


USER root
RUN pacman --noconfirm -U /home/user/linuxqq.pkg.tar.zst

USER user
RUN rm -rf ~/linuxqq && mkdir -p ~/.config/QQ
