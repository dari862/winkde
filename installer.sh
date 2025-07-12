#!/bin/sh
set -e

if [ "$(id -u)" -ne 0 ];then
    echo "Please run as root"
    exit 1
fi

mkdir -pm755 /etc/apt/keyrings
mkdir -p /usr/share/keyrings
dpkg --add-architecture i386
. /etc/os-release
if [ "$ID" = "debian" ];then
    taleifID="Debian"
    VERSION_ID_NO_DOT="$VERSION_ID"
elif [ "$ID" = "ubuntu" ];then
    taleifID="xUbuntu"
    package2install="kubuntu-restricted-addons finalrd"
    VERSION_ID_NO_DOT="$(echo "$VERSION_ID"| sed 's/.//g' )"
else
    echo "not supported distro"
    exit 1
fi

wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /usr/share/keyrings/microsoft.gpg > /dev/null
cp -rf /usr/share/keyrings/microsoft.gpg /usr/share/keyrings/microsoft-prod.gpg
cp -rf /usr/share/keyrings/microsoft.gpg /etc/apt/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge/ stable main" | tee /etc/apt/sources.list.d/microsoft-edge.list
echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/$ID/$VERSION_ID/prod ${VERSION_CODENAME} main" | tee /etc/apt/sources.list.d/microsoft-prod.list
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/ms-teams stable main" | tee /etc/apt/sources.list.d/teams.list
wget -q -O - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/${taleifID}_${VERSION_ID}/Release.key | gpg --dearmor | tee /usr/share/keyrings/obs-onedrive.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/obs-onedrive.gpg] https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/${taleifID}_${VERSION_ID}/ ./" | tee /etc/apt/sources.list.d/onedrive.list

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | tee /usr/share/keyrings/google-linux-signing-key.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list

wget -q -O - https://download.onlyoffice.com/GPG-KEY-ONLYOFFICE | gpg --dearmor | tee /usr/share/keyrings/onlyoffice.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main" | tee /etc/apt/sources.list.d/onlyoffice.list > /dev/null

wget -q -O - http://repo.steampowered.com/steam/archive/stable/steam.gpg | tee /usr/share/keyrings/steam.gpg > /dev/null
echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ stable steam" | tee /etc/apt/sources.list.d/steam-stable.list
echo "deb-src [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ stable steam" | tee -a /etc/apt/sources.list.d/steam-stable.list
echo "#deb [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ beta steam" | tee /etc/apt/sources.list.d/steam-beta.list
echo "#deb-src [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ beta steam" | tee -a /etc/apt/sources.list.d/steam-beta.list

wget -O - https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor | tee /etc/apt/keyrings/winehq-archive.key > /dev/null
wget -O - https://dl.winehq.org/wine-builds/$ID/dists/$VERSION_CODENAME/winehq-${VERSION_CODENAME}.sources | tee /etc/apt/sources.list.d/winehq-${VERSION_CODENAME}.sources > /dev/null

wget -qO - https://developer.download.nvidia.com/compute/cuda/repos/${ID}${VERSION_ID_NO_DOT}/x86_64/3bf863cc.pub | gpg --dearmor | tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/${ID}${VERSION_ID_NO_DOT}/x86_64/ /" | tee /etc/apt/sources.list.d/nvidia-drivers.list

if [ "$ID" = "debian" ];then
# Backup original sources.list
    cp -r /etc/apt/sources.list /etc/apt/sources.list.bak
    sed -i -E "s|^(deb.*${VERSION_CODENAME} main)( .*)?$|\1 contrib non-free non-free-firmware|g" /etc/apt/sources.list
elif [ "$ID" = "ubuntu" ];then
    add-apt-repository -y ppa:graphics-drivers/ppa
    add-apt-repository -y ppa:mozillateam/ppa
fi
tee /etc/apt/preferences.d/mozillateamppa <<- 'EOF' >/dev/null 2>&1
    Package: thunderbird*
    Pin: release o=LP-PPA-mozillateam
    Pin-Priority: 1001
EOF

apt update

package2install="$package2install
onlyoffice-desktopeditors
android-file-transfer
cheese
cpu-checker
cups-backend-bjnp
cups-tea4cups
cups-x2go
deborphan
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
ktorrent
libalure1
libcanberra-gtk3-module
libclutter-1.0-common
libcogl-common
libgsl27
libgstreamer-plugins-bad1.0-0
libgtkglext1
imagemagick
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
samba-ad-provision
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
net-tools
policykit-1
rar
gamemode
hardinfo
"

apt install -y $package2install
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y --system flathub com.heroicgameslauncher.hgl
flatpak install -y --system flathub com.github.tchx84.Flatseal

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

sed -i '/^\[Theme\]/,/^\[/{s/^Current=.*/Current=win11/;}' /etc/sddm.conf.d/default.conf
ln -sf /usr/share/plymouth/themes/win10/win10.plymouth /etc/alternatives/default.plymouth
update-initramfs -u

echo "done done done !!"
