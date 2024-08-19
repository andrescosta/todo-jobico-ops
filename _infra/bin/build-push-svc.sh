version=${1:-$(date +"%Y%m%d%H%M%S")}
docker build ../../todo-svc/ -t reg.jobico.org/todosvc:$version
docker push reg.jobico.org/todosvc:$version
