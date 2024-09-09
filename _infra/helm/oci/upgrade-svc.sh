version=$1
../../core/bin/build-push-svc.sh $version
helm upgrade --install todosvc oci://reg.jobico.org/helm-charts/todo-svc-jobico --set mode.dev.enabled=true --version=$version
