./build-push-svc.sh 0.4
./build-push-web.sh 0.4
kubectl create secret generic github-token --from-file=../argocd/token_git_hub.private
kubectl apply -f ../argocd/apps.yaml -n argocd
kubectl apply -f ../argocd/jobs.yaml
