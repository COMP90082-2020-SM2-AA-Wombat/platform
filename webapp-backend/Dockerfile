FROM python:3.6

COPY ./requirements.txt /requirements.txt

RUN pip install --upgrade pip && pip3 install -r requirements.txt

WORKDIR /app

EXPOSE 5000

ENTRYPOINT ["python"]

CMD ["app.py"]