#!/bin/sh

ENV=$1

cd tffile/environment/$ENV
terraform init -input=false -no-color
terraform destroy -input=false -no-color -auto-approve
