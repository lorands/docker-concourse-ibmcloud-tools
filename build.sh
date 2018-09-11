#!/bin/bash

relver=$(<VERSION)

set -ex
USERNAME=lorands
IMAGE=docker-concourse-ibmcloud-tools
docker build -t $USERNAME/$IMAGE:$relver .