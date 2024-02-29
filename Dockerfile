# TODO: make this dynamic, pass in as args
#FROM 1234567890.dkr.ecr.us-west-2.amazonaws.com/mycompany:latest
FROM 544034903395.dkr.ecr.us-west-2.amazonaws.com/yyao-privateai:20240206-cpu
#FROM python:3.8


RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         python3 \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && \
    pip install flask gevent gunicorn && \
        rm -rf /root/.cache

#pre-trained model package installation
RUN pip install spacy
RUN python -m spacy download en


# Set environment variables
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

COPY NER /opt/program
WORKDIR /opt/program