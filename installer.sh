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

test="
android-file-transfer
cheese
cid
cid-base
cid-gtk
cpu-checker
cups-backend-bjnp
cups-browsed-tests
cups-tea4cups
cups-x2go
deborphan
finalrd
flatpak
fontconfig
fonts-lato
fonts-takao-gothic
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
kmag
krb5-config
krb5-k5tls
ktorrent
kubuntu-restricted-addons
libalure1
libcanberra-gtk3-module
libclutter-1.0-common
libcogl-common
libgsl27
libgstreamer-plugins-bad1.0-0
libgtkglext1
libmagickcore-6.q16-7-extra
libosmesa6
libva-glx2
mangohud
microsoft-edge-stable
mozc-utils-gui
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
qemu-block-extra
qemu-system-gui
qemu-system-modules-opengl
qemu-system-modules-spice
qemu-system-x86
samba-ad-provision
qemu-system-gui
steam-launcher
steam-libs
steam-libs-amd64
steam-libs-i386
sugar-pippy-activity
sysbench
syslinux-common
thunderbird
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

git clone https://github.com/dari862/winkde /tmp/winkde
git clone https://github.com/mjkim0727/Eleven-icon-theme.git /tmp/winkde/Eleven-icon-theme
mv /tmp/winkde/Eleven-icon-theme/src/Eleven /tmp/winkde/usr/share/icons/
mv /tmp/winkde/usr/share/icons/Eleven-temp/* /tmp/winkde/usr/share/icons/Eleven
rm -rdf /tmp/winkde/usr/share/icons/Eleven-temp
cp -r /tmp/winkde/etc /
cp -r /tmp/winkde/usr /

apt install -f -y
fc-cache -vf
gtk-update-icon-cache
# does not work
sed -i '/^\[Theme\]/,/^\[/{s/^Current=.*/Current=win11/;}' /etc/sddm.conf.d/default.conf
ln -sf /usr/share/plymouth/themes/win10/win10.plymouth /etc/alternatives/default.plymouth
update-initramfs -u

echo "done done done !!"
