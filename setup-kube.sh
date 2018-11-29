#!/bin/bash

source "./kube-env.sh"
if [ $CLOUD_PROVIDER == "gcloud" ]; then
  if [ command -v gcloud >/dev/null 2>&1 ]; then
    echo "gcloud not installed, please install using this link https://cloud.google.com/sdk/docs/#windows"
    exit 1
  else
    echo $PROJECT_ID
    gcloud config set project $PROJECT_ID

    if [ $GOOGLE_CLUSTER_TYPE != "zonal" ] && [ $GOOGLE_CLUSTER_TYPE != "regional" ]; then
      echo "This is not a valid cluster type, please enter zonal or regional"
      exit 1
    fi

    if [ $GOOGLE_CLUSTER_TYPE == "zonal" ]; then
      gcloud config set compute/zone $GOOGLE_COMPUTE_ZONE
    else
      gcloud config set compute/region $GOOGLE_COMPUTE_REGION
    fi
    gcloud container clusters get-credentials $GOOGLE_CLUSTER_NAME
  fi
  fi
