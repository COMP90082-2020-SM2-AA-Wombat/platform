FROM jupyter/scipy-notebook

COPY requirements.txt /srv/requirements.txt

RUN pip install --upgrade pip && pip install -r requirements.txt

CMD ["start-singleuser.sh"]

USER jovyan
