version=1.0
helm package ../../helm/charts/todo-web-jobico/ -d ../../charts --version=$version --app-version=$version
helm package ../../helm/charts/todo-svc-jobico/ -d ../../charts --version=$version --app-version=$version
helm push ../../charts/todo-svc-jobico-${version}.tgz oci://reg.jobico.org/helm-charts 
helm push ../../charts/todo-web-jobico-${version}.tgz oci://reg.jobico.org/helm-charts
