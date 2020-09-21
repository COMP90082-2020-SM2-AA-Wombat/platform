FROM jupyter/scipy-notebook:latest

COPY ./requirements.txt /tmp/requirements.txt

RUN pip3 install -r /tmp/requirements.txt

WORKDIR $HOME