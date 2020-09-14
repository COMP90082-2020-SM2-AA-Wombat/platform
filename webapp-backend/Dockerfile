FROM python:3.6

WORKDIR /app

RUN pip install --upgrade pip && pip3 install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python"]

CMD ["app.py"]