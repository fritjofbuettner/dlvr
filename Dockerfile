FROM intel/dlstreamer

USER 0
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository -y ppa:deadsnakes/ppa && apt-get install -y python3.10
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN pip3.10 install poetry

