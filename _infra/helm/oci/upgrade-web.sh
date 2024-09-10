version=$1
../../core/bin/build-push-web.sh $version
helm upgrade --install todoweb oci://reg.jobico.org/helm-charts/todo-web-jobico --set mode.dev.enabled=true --version=$version
