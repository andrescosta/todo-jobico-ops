./build-push-web.sh

cat ../manifests/todo-web-deployment.yaml \
        | sed "s/{version}/$(date +"%Y%m%d%H%M%S")/"\
        | kubectl apply -f -
