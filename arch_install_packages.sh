#!/bin/bash

arch_packages=(
# audio
avahi pasystray pavucontrol pulseaudio
# spotify

# movies mpv qnapi rtorrent

# graphics
awesome dmenu mesa slock vicious xclip xsel
xorg-server xorg-xprop xorg-xinit xorg-setxkbmap
remmina freerdp tigervnc

# printing, scanning, pdf
cups cups-pdf hplip
mupdf zathura zathura-pdf-mupdf

# shell, terminals
bash fish zsh shellharden
fzf tabbed
termite tmux

# searching tools
awk sed the_silver_searcher ripgrep

# compilation, tags
ctags cscope
clang llvm llvm-libs
gcc gdb
openmp
intel-ucode

# build systems, source control
cmake make ninja
git

# interpreters
bc
bison
python python2 ruby

# text manipulation
dos2unix libreoffice texlive-most
gvim neovim python-neovim python2-neovim

# image manipulation
feh gimp imagemagick

# virtualization
qemu spice

# crypto
gnupg
pass
openssh
openssl

# filesystems, archives, file sharing, file manipulation
exfat-utils udiskie udisks2
p7zip tar unrar unzip
pv rsync tree

# networking
curl wget
networkmanager network-manager-applet networkmanager-openvpn nm-connection-editor
openvpn wireless_tools wpa_supplicant

# web, communication
bitlbee irssi pidgin
firefox qutebrowser w3m

# mail, rss
mailcap
mutt notmuch notmuch-mutt
msmtp offlineimap
thunderbird
newsboat
)

aur_packages=(
vgrep
buku
signal
megasync
periscope-git
boostnote
turtl
urlview
)

function install_packages {
  pacman -Sy --needed ${arch_packages[*]}
}

function install_yay {
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
  tar -xzvf yay.tar.gz
  cd yay
  makepkg -s
  pacman -U `ls yay*pkg.tar.xz`
}

function install_aur_packages {
  yay -Sy --needed ${aur_packages[*]}
}

install_packages
install_yay
install_aur_packages
