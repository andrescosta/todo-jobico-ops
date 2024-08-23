pushd ../
version=$(date +"%Y%m%d%H%M%S")
./build-push-svc.sh $version
helm upgrade todosvc ../helm/charts/todo-svc-jobico/ --set=image.tag=$version
popd
