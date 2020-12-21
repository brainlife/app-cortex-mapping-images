FROM ubuntu:18.04

MAINTAINER Brad Caron <bacaron@iu.edu>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:deadsnakes/ppa && apt-get install -y python3.7 && apt-get install -y jq git libpython3.7-dev python3-pip python3-setuptools python3-pyside python3-pyqt5 python3-pyqt4 libgl1-mesa-glx libegl1-mesa libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 mesa-utils libglu1-mesa libsm6

RUN pip3 install --upgrade pip
RUN python3.7 -m pip install -U mne matplotlib
RUN apt-get install -y xvfb
RUN python3.7 -m pip install xvfbwrapper
RUN python3.7 -m pip install nibabel
RUN python3.7 -m pip install pygments
RUN python3.7 -m pip install pyvista 
RUN python3.7 -m pip install --upgrade pip 
RUN python3.7 -m pip install pyvistaqt
RUN python3.7 -m pip install minimal
RUN python3.7 -m pip install PyQt5

#make it work under singularity 
RUN ldconfig && mkdir -p /N/u /N/home /N/dc2 /N/soft

#https://wiki.ubuntu.com/DashAsBinSh 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
