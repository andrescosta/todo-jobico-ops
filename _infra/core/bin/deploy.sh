#!/bin/bash

deploy_file_name="deploy.yaml"
deploy_full_path="../manifests/$deploy_file_name"

./build-push-svc.sh
./build-push-web.sh

if [ -f $deploy_full_path ]; then
    kubectl delete -f $deploy_full_path
    rm $deploy_full_path
fi

awk -v date="$timestamp" '
  FNR==1 && NR!=1 {print "---"}
  {gsub(/{version}/, date)}
  {print}
' ../manifests/*.yaml > $deploy_full_path

kubectl apply -f $deploy_full_path