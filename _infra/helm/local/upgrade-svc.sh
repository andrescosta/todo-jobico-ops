version=$1
../../build/build-push-svc.sh $version
helm upgrade --install todosvc ../todo-charts/charts/todo-svc-jobico/ --set=image.tag=$version
