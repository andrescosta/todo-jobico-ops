secret=$(kubectl get secret reg-cred-secret -ojson | jq -r '.data.".dockerconfigjson"' | base64 -d - | jq -r '"\(.auths."reg.jobico.org".username):\(.auths."reg.jobico.org".password)"' | tr -d '\n' | base64 -)
json=$(echo "{
  \"auths\": {
    \"https://reg.jobico.org/v1/\": {
      \"auth\": \"$secret\"
    }
  }
}")
kubectl create secret generic buildah-secret --from-literal=config.json="$json"
kubectl apply -f ../tektoncd/support/
kubectl apply -f ../tektoncd/pipeline/


