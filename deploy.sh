#!/bin/sh

AWS_URI="632747955816.dkr.ecr.ap-northeast-1.amazonaws.com"
IMAGE_NAME="sample-web"
IMAGE_URI="${AWS_URI}/${IMAGE_NAME}"
SCRIPT_DIR=`$(dirname $0); pwd`

# publish image
cd ${SCRIPT_DIR}/web
`aws ecr get-login --no-include-email`
docker-compose build
IMAGE_ID=`docker images --format="{{.ID}}" sample-web:latest`
docker tag $IMAGE_ID ${IMAGE_URI}:latest
docker push ${IMAGE_URI}:latest
docker tag $IMAGE_ID ${IMAGE_URI}:${IMAGE_ID}
docker push ${IMAGE_URI}:${IMAGE_ID}

# deploy
