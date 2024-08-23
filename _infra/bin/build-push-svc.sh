version=$1
docker build ../../todo-svc/ -t reg.jobico.org/todosvc:$version
docker push reg.jobico.org/todosvc:$version
