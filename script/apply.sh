#!/bin/sh

LAYER=$1
ENV=$2

cd tffile/environment/$LAYER/$ENV
terraform init -input=false -no-color
terraform apply -input=false -no-color -auto-approve
kubectl config set-context "kind-$ENV" --namespace echo-env
kubectl config use-context "kind-$ENV"
