#!/bin/bash

sudo yes | apt-get purge wolfram-engine
sudo yes | apt-get purge libreoffice*
sudo yes | apt-get clean
sudo yes | apt-get autoremove
sudo yes | apt-get update && sudo apt-get upgrade
sudo yes | apt-get install build-essential cmake unzip pkg-config
sudo yes | apt-get install libjpeg-dev libpng-dev libtiff-dev
sudo yes | apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo yes | apt-get install libxvidcore-dev libx264-dev
sudo yes | apt-get install libgtk-3-dev
sudo yes | apt-get install libcanberra-gtk*
sudo yes | apt-get install libatlas-base-dev gfortran
sudo yes | apt-get install python3-dev
cd ~
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.0.0-alpha.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.0.0-alpha.zip
unzip opencv.zip
unzip opencv_contrib.zip
mv opencv-4.0.0-alpha opencv
mv opencv_contrib-4.0.0-alpha opencv_contrib
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo pip install virtualenv virtualenvwrapper
sudo rm -rf ~/get-pip.py ~/.cache/pip
echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.profile
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.profile
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.profile
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.profile
source ~/.profile
mkvirtualenv cv -p python3
workon cv
pip install numpy
cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF ..
sudo sed -i 's/100/1024/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start    
make 
sudo make install
sudo ldconfig
cd ~/.virtualenvs/cv/lib/python3.5/site-packages/
ln -s /usr/local/lib/python3.5/site-packages/cv2.cpython-35m-arm-linux-gnueabihf.so cv2.so
cd ~
git clone https://github.com/robotpy/pynetworktables.git
cd pynetworktables
python setup.py install
sudo sed -i 's/1024/100/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start    