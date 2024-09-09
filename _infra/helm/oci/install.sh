version=1.0
pushd ../
./build-push-web.sh $version
./build-push-svc.sh $version
popd
helm install todosvc oci://reg.jobico.org/helm-charts/todo-svc-jobico --set mode.dev.enabled=true --set=image.tag=$version
helm install todoweb oci://reg.jobico.org/helm-charts/todo-web-jobico --set mode.dev.enabled=true --set=image.tag=$version