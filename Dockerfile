FROM node:16 AS frontend-build

WORKDIR /app
COPY package*.json ./
RUN npm ci --no-optional --quiet
COPY ["*.json", "*.js", "*.ts", "*.vue", "./"]
COPY plugins/ ./plugins/
RUN npm run build

FROM intel/dlstreamer

ENV DEBIAN_FRONTEND=noninteractive

USER 0
RUN apt-get update && apt-get install -y python3-pip
RUN python3 -m pip install -U pip
RUN python3 -m pip install poetry

WORKDIR /app
COPY pyproject.toml .
COPY poetry.lock .
ENV POETRY_VIRTUALENVS_CREATE=false
RUN python3 -m poetry install

RUN omz_downloader --name person-detection-0201
ADD "https://raw.githubusercontent.com/dlstreamer/dlstreamer/48b584ee1468fed295f83f33106e3bb2d7220ffa/samples/gstreamer/model_proc/intel/person-detection-0201.json" /app/intel/person-detection-0201.json

RUN chown -R dlstreamer /app
#USER dlstreamer

COPY --from=frontend-build /app/.output/public/ .output/public/
COPY api .

EXPOSE 10001
CMD python3 -m poetry run uvicorn --host 0.0.0.0 --port 10001 api.main:app