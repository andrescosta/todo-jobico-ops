pushd ../
version=$(date +"%Y%m%d%H%M%S")
./build-push-svc.sh $version
./build-push-web.sh $version
helm install todosvc ../helm/charts/todo-svc-jobico/ --set=image.tag=$version
helm install todoweb ../helm/charts/todo-web-jobico/ --set=image.tag=$version
popd
