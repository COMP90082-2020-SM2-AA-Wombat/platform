FROM jupyterhub/jupyterhub

COPY ./requirements.txt /tmp/requirements.txt

RUN pip3 install notebook

RUN pip3 install -r /tmp/requirements.txt

RUN pip3 install jupyterhub-nativeauthenticator 

RUN pip3 install DockerSpawner

COPY ./jupyterhub_config.py /tmp/jupyterhub_config.py

CMD jupyterhub -f /tmp/jupyterhub_config.py