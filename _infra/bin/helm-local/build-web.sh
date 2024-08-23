pushd ../
version=$(date +"%Y%m%d%H%M%S")
./build-push-web.sh $version
helm upgrade todoweb ../helm/charts/todo-web-jobico/ --set=image.tag=$version
popd