FROM node:16 AS frontend-build

WORKDIR /app
COPY package*.json ./
RUN npm ci --no-optional --quiet
COPY . ./
RUN npm run build

FROM intel/dlstreamer

USER 0
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get install -y python3.10 python3.10-distutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN pip3.10 install poetry

WORKDIR /app
COPY pyproject.toml .
COPY poetry.lock .
RUN python3.10 -m poetry install

COPY --from=frontend-build /app/.output/ .output/
COPY api .

EXPOSE 10001
CMD python3.10 -m poetry run uvicorn --host 0.0.0.0 --port 10001 api.main:app