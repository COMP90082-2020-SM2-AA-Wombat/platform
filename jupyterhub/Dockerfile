FROM jupyterhub/jupyterhub

# RUN  apt-get -yq update && \
#      apt-get -yqq install ssh
# RUN pip3 install notebook
# RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
# Warning! Anyone who gets their hands on this image will be able
# to retrieve this private key file from the corresponding image layer
# COPY ./jupyterlab/git-notebooks-key /root/.ssh/git-notebooks-key

# COPY ./jupyterlab/git-jupyterlab-key /root/.ssh/git-jupyterlab-key

# RUN ssh-keyscan -T 60 github.com >> /root/.ssh/known_hosts

# RUN docker build https://github.com/COMP90082-2020-SM2-AA-Wombat/jupyterlab.git#docker:master -t jupyterlab:custom

RUN pip3 install jupyterhub-nativeauthenticator 

RUN pip install repo2dockerspawner

# RUN openssl rand -hex 32 > /srv/jupyterhub/jupyterhub_cookie_secret && 

COPY ./jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py

CMD jupyterhub -f /etc/jupyterhub/jupyterhub_config.py