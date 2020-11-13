FROM 471625376696.dkr.ecr.us-east-1.amazonaws.com/ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y python3-pip python3-dev build-essential libpq-dev
RUN pip3 install --upgrade pip

COPY ./api /api

WORKDIR /api

RUN pip3 install --no-cache-dir -r requirements.txt

RUN echo Starting python and starting the Flask service...
ENTRYPOINT ["python3"]
CMD ["main.py"]