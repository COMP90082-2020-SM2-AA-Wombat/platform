FROM jupyter/scipy-notebook

COPY requirements.txt /srv/jupyterhub/requirements.txt

RUN pip install --upgrade pip && \
    pip install -r /srv/jupyterhub/requirements.txt

RUN pip install --upgrade jupyterlab jupyterlab-git 

RUN jlpm cache clean && \
    jupyter lab clean && \
    jupyter lab build 

CMD ["start-singleuser.sh"]

USER jovyan