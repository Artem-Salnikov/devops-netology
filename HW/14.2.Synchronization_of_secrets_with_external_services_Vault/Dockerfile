FROM fedora:latest

RUN mkdir /hvac && yum -y install pip && pip install hvac
WORKDIR /hvac
ADD hv.py /hvac


