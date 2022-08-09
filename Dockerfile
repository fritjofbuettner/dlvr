FROM node:16 AS frontend-build

WORKDIR /app
COPY package*.json ./
RUN npm ci --no-optional --quiet
COPY ["*.json", "*.js", "*.ts", "*.vue", "./"]
COPY plugins/ ./plugins/
RUN npm run build

FROM intel/dlstreamer

USER 0
RUN pip3 install poetry

WORKDIR /app
COPY pyproject.toml .
COPY poetry.lock .
RUN python3 -m poetry install

RUN chown -R dlstreamer /app
#USER dlstreamer

COPY --from=frontend-build /app/.output/public/ .output/public/
COPY api .

EXPOSE 10001
CMD python3 -m poetry run uvicorn --host 0.0.0.0 --port 10001 api.main:app