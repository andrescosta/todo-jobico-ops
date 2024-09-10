version=$1
../../core/bin/build-push-svc.sh $version
helm upgrade --install todosvc ../todo-charts/charts/todo-svc-jobico/ --set=image.tag=$version
