kubectl create cm build-map --from-file=./build.sh --dry-run=client -oyaml | kubectl apply --force -f -


