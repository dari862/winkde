#!/bin/sh
set -e

if [ "$EUID" -ne 0 ];then
    echo "Please run as root"
    exit 1
fi

mkdir -pm755 /etc/apt/keyrings
mkdir -p /usr/share/keyrings
dpkg --add-architecture i386

wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg
cp -r /usr/share/keyrings/microsoft.gpg /usr/share/keyrings/microsoft-prod.gpg
cp -r /usr/share/keyrings/microsoft.gpg /etc/apt/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge/ stable main" | tee /etc/apt/sources.list.d/microsoft-edge.list
echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/ubuntu/24.04/prod noble main" | tee /etc/apt/sources.list.d/microsoft-prod.list
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/ms-teams stable main" | tee /etc/apt/sources.list.d/teams.list
wget -q -O - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_24.04/Release.key | gpg --dearmor -o /usr/share/keyrings/obs-onedrive.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/obs-onedrive.gpg] https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_24.04/ ./" | tee /etc/apt/sources.list.d/onedrive.list

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-signing-key.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list

wget -q -O - https://download.onlyoffice.com/GPG-KEY-ONLYOFFICE | gpg --dearmor -o /usr/share/keyrings/onlyoffice.gpg
echo "deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main" | tee /etc/apt/sources.list.d/onlyoffice.list

wget -q -O - http://repo.steampowered.com/steam/archive/stable/steam.gpg | tee /usr/share/keyrings/steam.gpg > /dev/null
echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ stable steam" | tee /etc/apt/sources.list.d/steam-stable.list
echo "deb-src [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ stable steam" | tee -a /etc/apt/sources.list.d/steam-stable.list
echo "#deb [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ beta steam" | tee /etc/apt/sources.list.d/steam-beta.list
echo "#deb-src [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ beta steam" | tee -a /etc/apt/sources.list.d/steam-beta.list

wget -O - https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
wget -O /etc/apt/sources.list.d/winehq-noble.sources https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources

wget -qO - https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/3bf863cc.pub | gpg --dearmor | tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/ /" | tee /etc/apt/sources.list.d/nvidia-drivers.list

add-apt-repository -y ppa:mozillateam/ppa
tee /etc/apt/preferences.d/mozillateamppa << 'EOF' >/dev/null 2>&1
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
add-apt-repository -y ppa:graphics-drivers/ppa
add-apt-repository -y ppa:emoraes25/cid

apt update

test="0install-core
android-file-transfer
autoconf
automake
autopoint
build-essential
bzip2-doc
cabextract
caca-utils
chafa
cheese
cid
cid-base
cid-gtk
cmake
cpu-checker
cups-backend-bjnp
cups-browsed-tests
cups-tea4cups
cups-x2go
davfs2
debhelper
deborphan
dislocker
fakeroot
fcitx5-mozc
finalrd
flatpak
fontconfig
fonts-lato
fonts-takao-gothic
fuseiso
g++
gawk
geoip-database
gettext
glew-utils
gnome-calculator
google-chrome-stable
grdesktop
gstreamer1.0-plugins-bad
gstreamer1.0-plugins-ugly
gstreamer1.0-vaapi
guestfs-tools
gvfs
imagemagick
iperf3
ipxe-qemu-256k-compat-efi-roms
jp2a
kmag
krb5-config
krb5-k5tls
ktorrent
kubuntu-restricted-addons
libalgorithm-diff-perl
libalgorithm-diff-xs-perl
libalgorithm-merge-perl
libalure1
libaudio-scrobbler-perl
libcairo2-dev
libcanberra-gtk3-module
libcapi20-3t64
libcephfs2
libclutter-1.0-common
libcogl-common
libcupsfilters-dev
libfakeroot
libglib2.0-dev
libgmime-3.0-0t64
libgsl27
libgstreamer-plugins-bad1.0-0
libgtk-3-dev
libgtkglext1
libguestfs-hfsplus
libguestfs-reiserfs
libguestfs-tools
libguestfs-xfs
libinih-dev
libintl-xs-perl
libjson-glib-dev
libjs-sphinxdoc
libjxr-tools
libk3b-extracodecs
libltdl-dev
libmagickcore-6.q16-7-extra
libmail-sendmail-perl
libodbc2
libosmesa6
libpam-mount-bin
libpng-tools
libqt5opengl5-dev
librpmsign9t64
libsdl2-mixer-2.0-0
libsdl-mixer1.2
libsdl-ttf2.0-0
libsoup2.4-dev
libsoup-3.0-dev
libsystemd-dev
libtool
libva-glx2
libvirt-l10n
libxml2-dev
mangohud
meson
microsoft-edge-stable
mozc-utils-gui
mpg321
neofetch
network-manager
network-manager-openconnect
nghttp2
onboard
onboard-data
onedrive
ovmf
p11-kit
packages-microsoft-prod
plasma-discover-backend-flatpak
powershell
printer-driver-cups-pdf
python3-dev
python3-pip
python3-pygame
python3-smbc
qemu-block-extra
qemu-system-gui
qemu-system-modules-opengl
qemu-system-modules-spice
qemu-system-x86
qtbase5-dev
rpm
rpmlint
samba-ad-provision
snap
qemu-system-gui
steam-launcher
steam-libs
steam-libs-amd64
steam-libs-i386
sugar-pippy-activity
sysbench
syslinux-common
thunderbird
toilet
ttf-mscorefonts-installer
unrar
virt-p2v
vlc
vlc-l10n
vlc-plugin-access-extra
vlc-plugin-notify
vlc-plugin-samba
vlc-plugin-skins2
vlc-plugin-video-splitter
vlc-plugin-visualization
w3m-img
webcamoid
winehq-stable
wine-stable-i386
winetricks
xterm
yelp
zenity
apt-transport-https
krb5-doc
net-tools
policykit-1
rar
gamemode
"

apt install -y $test
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# does not exist
###########################
# 4kvideodownloaderplus
# hardinfo2 only hardinfo exist
# heroic
# onlyoffice
# teams
# steam:i386
# steam-installer
###########################
apt install -y hardinfo

flatpak install -y --system flathub com.heroicgameslauncher.hgl

wget https://dl.4kdownload.com/app/4kvideodownloaderplus_1.4.2-1_amd64.deb
dpkg -i ./4kvideodownloaderplus_1.4.2-1_amd64.deb || :

wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
dpkg -i ./onlyoffice-desktopeditors_amd64.deb || :

flatpak install -y --system flathub com.github.IsmaelMartinez.teams_for_linux

#systemctl enable --now onedrive

mkdir -p /tmp/winkde
tar -xzf winux_*.tar.gz -C /tmp/winkde
chown -R root:root /tmp/winkde
#git clone https://github.com/dari862/winkde /tmp/winkde
git clone https://github.com/mjkim0727/Eleven-icon-theme.git /tmp/Eleven-icon-theme
mv /tmp/Eleven-icon-theme/src/Eleven /tmp/winkde/usr/share/icons/
mv /tmp/winkde/usr/share/icons/Eleven-temp/* /tmp/winkde/usr/share/icons/Eleven
rm -rdf /tmp/winkde/usr/share/icons/Eleven-temp
cp -r /tmp/winkde/etc /
cp -r /tmp/winkde/usr /

apt install -f -y
fc-cache -vf
gtk-update-icon-cache
# does not work
#sed -i '/^\[Theme\]/,/^\[/{s/^Current=.*/Current=win11/;}' /etc/sddm.conf.d/kde_settings.conf
#plymouth-set-default-theme win10
#update-initramfs -u

echo "done done done !!"
