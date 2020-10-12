FROM jupyterhub/jupyterhub

RUN pip3 install jupyterhub-nativeauthenticator 

RUN pip install repo2dockerspawner

COPY ./jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py

CMD jupyterhub -f /etc/jupyterhub/jupyterhub_config.py