#!/bin/sh

LAYER=$1
ENV=$2

cd tffile/environment/$LAYER/$ENV
terraform init -input=false -no-color
terraform apply -input=false -no-color -auto-approve
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
