version=$(date +"%Y%m%d%H%M%S")
docker build ../../todo-svc/ -t reg.jobico.org/todosvc:$version
docker push reg.jobico.org/todosvc:$version
helm upgrade svc ../helm/charts/todo-svc-jobico/ --set=image.tag=$version
