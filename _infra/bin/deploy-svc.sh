./build-push-svc.sh

cat ../manifests/todosvc-deployment.yaml \
        | sed "s/{version}/$(date +"%Y%m%d%H%M%S")/"\
        | kubectl apply -f -
