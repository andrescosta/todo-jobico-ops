version=$(date +"%Y%m%d%H%M%S")
docker build ../../todo-web/ -t reg.jobico.org/todoweb:$version
docker push reg.jobico.org/todoweb:$version
helm upgrade svc ../helm/charts/todo-web-jobico/ --set=image.tag=$version
