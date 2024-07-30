docker build ../../todo-svc/ -t reg.jobico.org/todosvc:latest 
docker push reg.jobico.org/todosvc:latest

docker build ../../todo-web/ -t reg.jobico.org/todoweb:latest 
docker push reg.jobico.org/todoweb:latest

kubectl delete -f ../manifests/deploy.yaml 
rm ../manifests/deploy.yaml
awk 'FNR==1 && NR!=1 {print "---"} {print}' ../manifests/*.yaml > ../manifests/deploy.yaml
kubectl apply -f ../manifests/deploy.yaml 
