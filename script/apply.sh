#!/bin/sh

LAYER=$1
ENV=$2

cd tffile/environment/$LAYER/$ENV
terraform init -input=false -no-color
terraform apply -input=false -no-color -auto-approve
