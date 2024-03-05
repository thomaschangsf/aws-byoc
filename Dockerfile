FROM 544034903395.dkr.ecr.us-west-2.amazonaws.com/yyao-privateai:20240206-cpu
#FROM python:3.8

# Set a docker label to advertise multi-model support on the container
LABEL com.amazonaws.sagemaker.capabilities.multi-models=true

# Set a docker label to enable container to use SAGEMAKER_BIND_TO_PORT environment variable if present
# LABEL com.amazonaws.sagemaker.capabilities.accept-bind-to-port=true

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

RUN apt-get update && \
    apt-get install -y iputils-ping

# Set environment variables
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

COPY NER /opt/program
WORKDIR /opt/program

ENTRYPOINT ["serve"]
