FROM alpine:3.13

RUN \
  apk update && \
  apk add bash py-pip && \
  apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make && \
  apk add curl jq python3 ca-certificates git openssl unzip wget && \
  pip --no-cache-dir install -U pip && \
  pip install azure-cli && \
  apk del --purge build

RUN wget https://releases.hashicorp.com/terraform-provider-random/3.1.0/terraform-provider-random_3.1.0_linux_amd64.zip &&  \
    unzip terraform-provider-random_3.1.0_linux_amd64.zip && \
    chmod +x terraform-provider-random_v3.1.0_x5 && \
    mkdir -p .terraform.d/plugins/registry.terraform.io/hashicorp/random/3.1.0/linux_amd64 && \
    mv terraform-provider-random_v3.1.0_x5 .terraform.d/plugins/registry.terraform.io/hashicorp/random/3.1.0/linux_amd64 && \
    rm -f terraform-provider-random_3.1.0_linux_amd64.zip

RUN wget https://releases.hashicorp.com/terraform-provider-alicloud/1.140.0/terraform-provider-alicloud_1.140.0_linux_amd64.zip && \
    unzip terraform-provider-alicloud_1.140.0_linux_amd64.zip && \
    chmod +x terraform-provider-alicloud_v1.140.0 && \
    mkdir -p .terraform.d/plugins/registry.terraform.io/hashicorp/alicloud/1.140.0/linux_amd64 && \
    mv terraform-provider-alicloud_v1.140.0 .terraform.d/plugins/registry.terraform.io/hashicorp/alicloud/1.140.0/linux_amd64 && \
    rm -f terraform-provider-alicloud_1.140.0_linux_amd64.zip

COPY .terraform.d /root/.terraform.d
