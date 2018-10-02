FROM nimmis/alpine-glibc:latest

ADD VERSION .

# ENV BX_SPACE ""
# ENV BX_API_ENDPOINT api.ng.bluemix.net
# ENV BLUEMIX_API_KEY ""

#RUN apk update
RUN apk add --no-cache bash ca-certificates curl jq python3 git build-base
RUN update-ca-certificates

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN \
pip3 install git+https://github.com/lorands/concourse-python-tooling.git

WORKDIR /tmp
RUN curl -o /tmp/Bluemix_CLI.tar.gz https://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/0.9.0/IBM_Cloud_CLI_0.9.0_amd64.tar.gz && \
  tar zxvf Bluemix_CLI.tar.gz && \
  Bluemix_CLI/install_bluemix_cli && \
  rm -f /tmp/Bluemix_CLI.tar.gz && \
  rm -rf /tmp/Bluemix_CLI 
WORKDIR /


RUN bx plugin install activity-tracker -r Bluemix -f
RUN bx plugin install analytics-engine -r Bluemix -f
RUN bx plugin install auto-scaling -r Bluemix -f
RUN bx plugin install cloud-functions -r Bluemix -f
RUN bx plugin install cloud-internet-services -r Bluemix -f
RUN bx plugin install container-registry -r Bluemix -f
RUN bx plugin install container-service -r Bluemix -f
##RUN bx plugin install dbaas-cli -r Bluemix -f
RUN bx plugin install dev -r Bluemix -f
##RUN bx plugin install IBM-Containers -r Bluemix -f
RUN bx plugin install infrastructure-service -r Bluemix -f
RUN bx plugin install logging-cli -r Bluemix -f
RUN bx plugin install machine-learning -r Bluemix -f
RUN bx plugin install private-network-peering -r Bluemix -f
RUN bx plugin install sdk-gen -r Bluemix -f
RUN bx plugin install vpn -r Bluemix -f

RUN bx config --check-version=false



