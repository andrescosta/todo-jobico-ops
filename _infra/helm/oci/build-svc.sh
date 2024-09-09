pushd ../
./build-push-svc.sh 1.0
popd
helm upgrade todosvc oci://reg.jobico.org/helm-charts/todo-svc-jobico
