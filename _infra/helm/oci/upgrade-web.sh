version=$1
../../build/build-push-web.sh $version
helm upgrade --install todoweb oci://reg.jobico.local/helm-charts/todo-web-jobico --set mode.dev.enabled=true --version=$version
