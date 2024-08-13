argocd app create todo --repo https://github.com/andrescosta/todo-jobico-cloud.git --path _infra/manifests --dest-server https://kubernetes.default.svc --dest-namespace default
argocd app sync todo
