FROM alpine:3.13

RUN \
  apk update && \
  apk add bash py-pip && \
  apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make && \
  apk add curl jq python3 ca-certificates git openssl unzip wget && \
  pip --no-cache-dir install -U pip && \
  pip install azure-cli && \
  apk del --purge build

COPY .terraform.d /root/.terraform.d
