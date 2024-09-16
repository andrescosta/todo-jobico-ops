version=$1
../../build/build-push-svc.sh $version
helm upgrade --install todosvc oci://reg.jobico.local/helm-charts/todo-svc-jobico --set mode.dev.enabled=true --version=$version
