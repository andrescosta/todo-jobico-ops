pushd ../
kubectl create secret generic github-token --from-file=tokens/token_git_hub.private
kubectl apply -f manifests/jobs.yaml
kubectl apply -f manifests/apps.yaml -n argocd
popd
