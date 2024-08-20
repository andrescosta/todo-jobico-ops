version="1.1.$(git rev-list HEAD --count --no-merges)"
./build-push-svc.sh $version 
./build-push-web.sh $version
kubectl create secret generic github-token --from-file=../id/token_git_hub.private
kubectl apply -f ../argocd/apps.yaml -n argocd
kubectl apply -f ../argocd/jobs.yaml
