version=1.0
mkdir -p ../pkgs
pushd ../todo-charts
helm package charts/todo-web-jobico/ -d ../pkgs --version=$version --app-version=$version
helm package charts/todo-svc-jobico/ -d ../pkgs --version=$version --app-version=$version
helm push ../pkgs/todo-svc-jobico-${version}.tgz oci://reg.jobico.org/helm-charts 
helm push ../pkgs/todo-web-jobico-${version}.tgz oci://reg.jobico.org/helm-charts
