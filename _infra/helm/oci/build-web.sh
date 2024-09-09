pushd ../
./build-push-web.sh 1.0
popd
helm upgrade todoweb oci://reg.jobico.org/helm-charts/todo-web-jobico
