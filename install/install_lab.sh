echo ####################################################
echo ##### Medical Imaging Post Startup Script Start ####
echo ####################################################
echo ##### Uodate Nodejs, jupyterlab widgets, and ipycanvas ####
echo ####################################################
npm install --global yarn
pip uninstall --yes jupyterlab_widgets
pip install --user ipycanvas
NODE_OPTIONS=--max-old-space-size=8192 jupyter labextension update --all
pip install --user --no-deps ipyevents
echo "##### Uodate Nodejs, jupyterlab widgets, and ipycanvas ####" > /tmp/slicer-post-install.log

jupyter labextension list  >> /tmp/slicer-post-install.log

echo ####################################################
echo #####  Clone ipycanvas                         #####
export HOME="/home/jupyter"
cd $HOME
git clone https://github.com/martinRenou/ipycanvas
echo "#####  Clone ipycanvas                         #####" >> /tmp/slicer-post-install.log

echo ####################################################
echo #####  Configure TurboVNC                      #####
sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y dbus-x11 xfce4 xfce4-panel xfce4-session xfce4-settings xorg elementary-xfce-icon-theme

wget 'https://sourceforge.net/projects/turbovnc/files/2.2.5/turbovnc_2.2.5_amd64.deb/download' -O turbovnc_2.2.5_amd64.deb
sudo apt-get install -y -q ./turbovnc_2.2.5_amd64.deb

sudo apt-get remove -y -q light-locker 
sudo rm ./turbovnc_2.2.5_amd64.deb 
sudo ln -s /opt/TurboVNC/bin/* /usr/local/bin/
echo "#####  Configure TurboVNC                      #####" >> /tmp/slicer-post-install.log

echo ####################################################
echo #####  Configure updated JupyterLab options    #####

echo ### add path of new packages to /etc/profile ###
export CONDA_DIR=/opt/conda
export HOME="/home/jupyter"
export PATH="${CONDA_DIR}/bin:/usr/sbin:/usr/bin:/sbin:/bin:${HOME}/Slicer/lib/Python/bin:${HOME}/.local/bin:${PATH}"
export DISPLAY=":1.0"
printf "export DISPLAY=$DISPLAY \nexport MIL_VERSION=1 \nexport PATH=$PATH" > /tmp/mil.env
sudo sh -c 'cat /tmp/mil.env >> /etc/profile'
echo "#####  Configure updated JupyterLab options    #####" >> /tmp/slicer-post-install.log

echo #######################################################
echo ########### Installing Jupyter Desktop ################
# install websockify
mkdir $HOME/websockify
cd $HOME/websockify
wget "https://github.com/novnc/websockify/archive/refs/heads/master.zip" -O websockify.zip
unzip ./websockify.zip
cd websockify-master
make
cp rebind.so $CONDA_DIR/lib
pip install -e .
# install jupyter_desktop
mkdir $HOME/jupyter_desktop
cd $HOME/jupyter_desktop
wget 'https://github.com/yuvipanda/jupyter-desktop-server/archive/refs/heads/master.zip' -O jupyter-desktop-server.zip
unzip ./jupyter-desktop-server.zip
cd jupyter-desktop-server-master
pip install -e .
echo "########### Installing Jupyter Desktop ################" >> /tmp/slicer-post-install.log

echo ####################################################
echo ########## Installing Chrome Browser ###############
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

# Install Mousepad so we can edit / run kernel.
sudo apt-get install -y mousepad
# configure software version
VMNAME=$(curl -H Metadata-Flavor:Google http://metadata/computeMetadata/v1/instance/hostname | cut -d. -f1)
ZONE=$(curl -H Metadata-Flavor:Google http://metadata/computeMetadata/v1/instance/zone | cut -d/ -f4)
gcloud compute instances update $VMNAME --zone=$ZONE --update-labels=goog-packaged-solution=medical-imaging-suite
gcloud compute instances update $VMNAME --zone=$ZONE --update-labels=mis_version=1
echo "########## Installing Chrome Browser ###############" >> /tmp/slicer-post-install.log

echo ####################################################
echo #### Get 3DSlicer                               ####
cd /tmp
# mkdir /home/jupyter/Slicer
# chown jupyter /home/jupyter/Slicer
# chmod +rwx /home/jupyter/Slicer
wget 'https://download.slicer.org/bitstream/631abfb5e911182f1df2a07a' -O slicer.tar.gz
tar -xf ./slicer.tar.gz
chown jupyter ./Slicer*
mv ./Slicer* /home/jupyter/Slicer
chown jupyter /home/jupyter/Slicer
chmod +rwx /home/jupyter/Slicer
chmod +rwx /home/jupyter/Slicer/*

echo "#### Get 3DSlicer                               ####" >> /tmp/slicer-post-install.log

echo ####################################################
echo #####  Configure dependencies                  #####

sudo apt-get install -y libpulse-dev libnss3 libglu1-mesa
sudo apt-get install -y --reinstall libxcb-xinerama0
sudo apt-get install -y libxkbcommon-x11-0
echo ##### install libxcb-util #####
sudo apt-get install -y xcb
sudo apt install -y libxcb-xkb1
sudo apt-get install -y qt5-default

echo ##### add missing links ####
sudo ln -s /usr/lib/x86_64-linux-gnu/libxcb-util.so.0.0.0 /usr/lib/x86_64-linux-gnu/libxcb-util.so.1
sudo ln -s /usr/lib/x86_64-linux-gnu/libxcb-util.so.0.0.0 /usr/lib/x86_64-linux-gnu/libxcb-util.so
echo "#####  Configure dependencies                  #####" >> /tmp/slicer-post-install.log

echo #### Create the Slicer extensions directory

sudo chown jupyter $HOME/Slicer
mkdir $HOME/Slicer/NA-MIC
chown jupyter $HOME/Slicer/NA-MIC
chmod +rwx $HOME/Slicer/NA-MIC
mkdir $HOME/Slicer/NA-MIC/Extensions-31126
echo #### Slicer Permissions Check ###  >> /tmp/slicer-post-install.log
ls -latr $HOME/Slicer >> /tmp/slicer-post-install.log
ls -latr $HOME/Slicer/NA-MIC >> /tmp/slicer-post-install.log
echo "#### Create the Slicer extensions directory" >> /tmp/slicer-post-install.log


echo #####  install additional packages in the slicer environment ####
$HOME/Slicer/bin/PythonSlicer -m pip install ipython ipywidgets==8.0.2 ipyevents ipycanvas
echo "#####  install additional packages in the slicer environment ####" >> /tmp/slicer-post-install.log

echo "########################################" >> /tmp/slicer-post-install.log
echo "##### Post Startup Script Complete #####" >> /tmp/slicer-post-install.log
echo "########################################" >> /tmp/slicer-post-install.log

