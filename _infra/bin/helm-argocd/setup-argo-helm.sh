pushd ../
kubectl create secret generic github-token --from-file=../id/token_git_hub.private
kubectl apply -f ../argocd/jobs.yaml
kubectl apply -f ../argocd/apps.yaml -n argocd
popd
