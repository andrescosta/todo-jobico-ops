docker build . -f ./Dockerfile -t reg.jobico.local/buildah
docker push reg.jobico.local/buildah
./deploy-build.sh $1
