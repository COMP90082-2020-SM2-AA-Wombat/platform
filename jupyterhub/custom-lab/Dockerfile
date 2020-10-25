FROM jupyter/scipy-notebook

COPY requirements.txt /srv/requirements.txt

RUN pip install --upgrade pip && pip install -r /srv/requirements.txt

# ENTRYPOINT ["tini", "--", "/srv/docker-entrypoint.sh"]

CMD ["start-singleuser.sh"]

USER jovyan
