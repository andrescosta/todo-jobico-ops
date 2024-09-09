version=$1
../../core/bin/build-push-web.sh $version
helm upgrade --install todoweb ../todo-charts/charts/todo-web-jobico/ --set=image.tag=$version
