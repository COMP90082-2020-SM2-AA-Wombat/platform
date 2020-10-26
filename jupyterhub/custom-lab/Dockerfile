FROM jupyter/scipy-notebook

COPY requirements.txt /srv/jupyterhub/requirements.txt

RUN pip install --upgrade pip && \
    pip install -r /srv/jupyterhub/requirements.txt

RUN pip install jupyterlab-git && \
    jupyter serverextension enable --py --sys-prefix jupyterlab_git && \
    jupyter labextension install @jupyterlab/git

CMD ["start-singleuser.sh"]

USER jovyan