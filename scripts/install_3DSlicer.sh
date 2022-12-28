# use non interactive flag
export DEBIAN_FRONTEND=noninteractive

wget 'https://download.slicer.org/bitstream/631abfb5e911182f1df2a07a' -O slicer.tar.gz
tar -xf ./slicer.tar.gz
mv ./Slicer* /home/jupyter/Slicer
sudo apt-get install -y libpulse-dev libnss3 libglu1-mesa
sudo apt-get install -y --reinstall libxcb-xinerama0
sudo apt-get install -y libxkbcommon-x11-0
# install libxcb-util
sudo apt-get install -y xcb
sudo apt install -y libxcb-xkb1
sudo apt-get install -y qt5-default

# add missing links
sudo ln -s /usr/lib/x86_64-linux-gnu/libxcb-util.so.0.0.0 /usr/lib/x86_64-linux-gnu/libxcb-util.so.1
sudo ln -s /usr/lib/x86_64-linux-gnu/libxcb-util.so.0.0.0 /usr/lib/x86_64-linux-gnu/libxcb-util.so

#install additional packages in the slicer environment

/home/jupyter/Slicer/bin/PythonSlicer -m pip install --upgrade ipython ipywidgets ipyevents ipycanvas

### need to add /home/jupyter/Slicer/lib/Python/bin to PATH in etc/profile. This was done in the install_desktop script

