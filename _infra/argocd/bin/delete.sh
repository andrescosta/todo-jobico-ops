pushd ../
kubectl delete secret github-token
kubectl delete -f manifests/jobs.yaml
kubectl delete -f manifests/apps.yaml -n argocd
popd
