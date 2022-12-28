export DEBIAN_FRONTEND=noninteractive

echo "########### Installing XFCE Desktop ############"
sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y dbus-x11 xfce4 xfce4-panel xfce4-session xfce4-settings x11-xkb-utils xorg elementary-xfce-icon-theme
echo "########### Installing Turbo VNC ###############"
wget 'https://sourceforge.net/projects/turbovnc/files/2.2.5/turbovnc_2.2.5_amd64.deb/download' -O turbovnc_2.2.5_amd64.deb
sudo apt-get install -y -q ./turbovnc_2.2.5_amd64.deb
#  Remove light-locker to prevent screen lock
sudo apt-get remove -y -q light-locker 
sudo rm ./turbovnc_2.2.5_amd64.deb 
sudo ln -s /opt/TurboVNC/bin/* /usr/local/bin/
sudo ln -s /opt/conda/bin/dbus-launch /usr/bin/dbus-launch

#re-install NVIDIA drivers
sudo /opt/deeplearning/uninstall-driver.sh
sudo /opt/deeplearning/install-driver.sh

# add path of new packages to /etc/profile
export CONDA_DIR=/opt/conda 
export HOME="/home/jupyter"
export PATH="${CONDA_DIR}/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/jupyter/Slicer/lib/Python/bin:${PATH}"
printf "export MIL_VERSION=1 \nexport PATH=$PATH\nexport DISPLAY=:1.0" > /tmp/mil.env
sudo sh -c 'cat /tmp/mil.env >> /etc/profile'

echo "########### Installing Jupyter Desktop ################"
mkdir $HOME/jupyter_desktop
cd $HOME/jupyter_desktop
wget 'https://github.com/yuvipanda/jupyter-desktop-server/archive/refs/heads/master.zip' -O jupyter-desktop-server.zip
unzip ./jupyter-desktop-server.zip
cd jupyter-desktop-server-master
conda env update -n base --file environment.yml

echo "########## Installing Chrome Browser ##############"
sudo dpkg --configure -a
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

