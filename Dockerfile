FROM nimmis/alpine-glibc:latest

ADD VERSION .

# ENV BX_SPACE ""
# ENV BX_API_ENDPOINT api.ng.bluemix.net
# ENV BLUEMIX_API_KEY ""

#RUN apk update
RUN apk add --no-cache bash ca-certificates curl jq python3
RUN update-ca-certificates

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
