#!/bin/sh

# required aws command & credential

REGION=ap-northeast-1
CLUSTER_NAME=ponkotuy

aws eks --region=ap-northeast-1 update-kubeconfig --name $CLUSTER_NAME
