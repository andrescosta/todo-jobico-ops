version=$(date +"%Y%m%d%H%M%S")
./upgrade-svc.sh $version
./upgrade-web.sh $version
