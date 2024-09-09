docker build . -f ./Dockerfile -t reg.jobico.org/buildah
docker push reg.jobico.org/buildah
./deploy-build.sh $1
