resources='[
    {
        "build-dir": "todo-svc",
        "image-name": "reg.jobico.org/todo-svc:latest"
    },
    {
        "build-dir": "todo-web",
        "image-name": "reg.jobico.org/todo-web:latest"
    }
]'
body='{
"resources": '$resources',
"repo-url": "https://github.com/andrescosta/todo-jobico-cloud",
"repo-revision": "main"
}'

curl -X POST \
    -H "Content-Type: application/json" \
    -d "$body" \
    localhost:8080

