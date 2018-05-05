FROM python:3.5
MAINTAINER John Domingo "jbdomingo76@gmail.com"
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["web_api.py"]
