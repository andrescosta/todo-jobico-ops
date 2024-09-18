version=$1
docker build ../../../todo-svc/ -t reg.jobico.local/todosvc:$version
docker push reg.jobico.local/todosvc:$version
