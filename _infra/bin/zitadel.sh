key_path=~/Downloads/278299716364534279.json

go install github.com/zitadel/zitadel-tools@latest

assertion=$(zitadel-tools key2jwt --audience https://id.jobico.org --key $key_path)
data_assertion="assertion=$assertion"

token_response=$(curl -s --request POST \
    --url https://id.jobico.org/oauth/v2/token \
    --header 'Content-Type: application/x-www-form-urlencoded'  \
    --data grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer \
    --data scope='openid profile urn:zitadel:iam:org:project:id:zitadel:aud' \
    --data "$data_assertion")

access_token=$(echo "$token_response" | jq -r '.access_token')
echo "accesstoken: $access_token"
header_bearer="Bearer $access_token"

json_response=$(curl -s -L 'https://id.jobico.org/management/v1/projects' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: $header_bearer" \
-d '{
  "name": "Todo for Jobico Cloud"
}')

proj_id=$(echo "$json_response" | jq -r '.id')
url="https://id.jobico.org/management/v1/projects/$proj_id/apps/oidc"

curl -s -L "$url" \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: $header_bearer" \
-d '{
    "name": "todo project",
    "redirectUris": [
        "http://localhost:3000/callback",
        "http://localhost:3000",
        "http://localhost:3000/",
        "https://todo.jobico.org/",
        "https://todo.jobico.org"
    ],
    "responseTypes": [
        "OIDC_RESPONSE_TYPE_CODE"
    ],
    "grantTypes": [
        "OIDC_GRANT_TYPE_AUTHORIZATION_CODE"
    ],
    "appType": "OIDC_APP_TYPE_USER_AGENT",
    "authMethodType": "OIDC_AUTH_METHOD_TYPE_NONE",
    "postLogoutRedirectUris": [
        "http://localhost:3000",
        "http://localhost:3000/",
        "https://id.jobico.org",
        "https://todo.jobico.org/",
        "https://todo.jobico.org"
    ],
    "devMode": true,
    "accessTokenRoleAssertion": true,
    "idTokenUserinfoAssertion": true,
    "clockSkew": "0s"
}'

json_response=$(curl -s -L 'https://id.jobico.org/management/v1/actions' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: $header_bearer" \
-d '{
  "name": "preUserCreationJobico",
  "script": "let uuidlib = require(\"zitadel/uuid\")\nfunction preUserCreationJobico(ctx, api) {\n  api.v1.user.appendMetadata(\"jobico-id\", uuidlib.v4());\n  api.setEmailVerified(true)\n}",
  "timeout": "10s",
  "allowedToFail": true
}')

id=$(echo "$json_response" | jq -r '.id')
json_payload="{\"actionIds\": [\"$id\"]}"
curl -s -L 'https://id.jobico.org/management/v1/flows/3/trigger/2' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: $header_bearer" \
-d "$json_payload"
