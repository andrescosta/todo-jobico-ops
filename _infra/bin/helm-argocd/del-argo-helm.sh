pushd ../
kubectl delete -f ../argocd/jobs.yaml
kubectl delete -f ../argocd/apps.yaml -n argocd
popd
