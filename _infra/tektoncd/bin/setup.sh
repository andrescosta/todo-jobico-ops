secret=$(kubectl get secret reg-cred-secret -ojson | jq -r '.data.".dockerconfigjson"' | base64 -d - | jq -r '"\(.auths."reg.jobico.local".username):\(.auths."reg.jobico.local".password)"' | tr -d '\n' | base64 -)
json=$(echo "{
  \"auths\": {
    \"https://reg.jobico.local/v1/\": {
      \"auth\": \"$secret\"
    }
  }
}")
kubectl create secret generic buildah-secret --from-literal=config.json="$json"
kubectl apply -f ../support/
kubectl apply -f ../pipeline/


