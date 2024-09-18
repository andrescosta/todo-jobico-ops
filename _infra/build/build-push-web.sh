version=${1:-$(date +"%Y%m%d%H%M%S")}
docker build ../../../todo-web/ -t reg.jobico.local/todoweb:$version
docker push reg.jobico.local/todoweb:$version
