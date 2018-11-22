#!/bin/bash
# This is a script that will help you set up your kubernetes file
# It will get credentials from AWS or GCLOUD for kubernetes
# It will NOT handle the installation of those SDKs.
for i in "$@"
do
case $i in
    -c=*|--cloudprovider=*)
    CLOUDPROVIDER="${i#*=}"
    shift # past argument=value
    ;;
esac
done


if [ -z "$CLOUDPROVIDER" ]; then
  echo "Please pass a cloud provider"
  exit 1
fi

if [ "$CLOUDPROVIDER" != "gcloud" ] && [ "$CLOUDPROVIDER" != "aws" ]; then
  echo "Please pass in gcloud or aws for --cloudprovider"
  exit 1
fi

# We are using gcloud as a provider
if [ $CLOUDPROVIDER == "gcloud" ]; then
  echo "Am I in the right branch?"
  # We want to check if the gcloud command exists
  # If not, we want to install it

  if [ command -v gcloud >/dev/null 2>&1 ]; then
    echo "gcloud not installed, please install using this link https://cloud.google.com/sdk/docs/#windows"
    exit 1
  else
    echo "Please enter project id"
    read PROJECTID
    gcloud config set project $PROJECTID

    echo "Please enter project name"
    read XELPMOC_PROJECTNAME
    export XELPMOC_PROJECTNAME
    # gcloud is installed
    # we want to get the cluster name
    echo "Please enter cluster name"
    read CLUSTERNAME

    echo "Is this a zonal or regional cluster?"
    read CLUSTERTYPE

    if [ $CLUSTERTYPE != "zonal" ] && [ $CLUSTERTYPE != "regional" ]; then
      echo "This is not a valid cluster type, please enter zonal or regional"
      exit 1
    fi

    if [ $CLUSTERTYPE == "zonal" ]; then
      echo "Please enter zone name"
      read ZONE
      gcloud config set compute/zone $ZONE
    else
      echo "Please enter region name"
      read REGION
      gcloud config set compute/region $REGION
    fi
    gcloud container clusters get-credentials $CLUSTERNAME

  fi
fi