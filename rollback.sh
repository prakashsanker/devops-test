#!/bin/bash
echo "This is an utility script to help you rollback if there is a bug"
echo "PLEASE USE THIS CAREFULLY"
echo "First, let's make sure you're in the right cluster"
echo "Check the config below to make sure you are in the right cluster"
kubectl config view

read -p "Are you in the right cluster? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    echo "here are the revisions you can roll back to"
    # ok now perform a rollback
    kubectl rollout history deployment.v1.apps/$XELPMOC_PROJECTNAME

    echo "Which one do you want to rollback to?"
    read REVISION_TO_ROLLBACK_TO
    kubectl rollout undo deployment.v1.apps/$XELPMOC_PROJECTNAME
else
  echo "Please use ./setup-kube-config.sh to set up correctly"
  exit 1
fi
