FROM python:3.6

COPY ./requirements.txt /requirements.txt

RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 5000

WORKDIR /app

ENTRYPOINT ["python"]

CMD ["app.py"]