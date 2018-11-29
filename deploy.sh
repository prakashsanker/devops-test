#!/bin/bash

# This is a script that will deploy your current branch to the staging environment for this project
# To do this I need to


branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
branch_name="(unnamed branch)"

echo "Is this the branch you want to push to staging?"
echo $branch_name

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # now we need to use docker
  # blargh, how do I
  source "./kube-env.sh"
  if [ command -v docker >/dev/null 2>&1 ]; then
    echo "docker is not installed, please install docker"
    exit 1
  fi
  # Now we build the docker image and push to the docker registry
  COMMIT_SHA="$(git rev-parse HEAD)"
  echo $COMMIT_SHA
  docker build --build-arg COMMIT_REF=$COMMIT_SHA --build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` -t $PROJECT_NAME .
  docker tag $PROJECT_NAME asia.gcr.io/$PROJECT_ID/$PROJECT_NAME:$COMMIT_SHA
  gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://asia.gcr.io
  docker push asia.gcr.io/$PROJECT_ID/$PROJECT_NAME:$COMMIT_SHA
  echo $PROJECT_NAME
  sed "s/\${PROJECT_NAME}/$PROJECT_NAME/g" k8s.yml > project_name_patched.yml
  sed "s/\${GOOGLE_PROJECT_ID}/$PROJECT_ID/g" project_name_patched.yml > project_id_patched.yml
  sed "s/\${CIRCLE_SHA1}/$COMMIT_SHA/g" project_id_patched.yml > patched_k8s.yml

  rm project_name_patched.yml
  rm project_id_patched.yml

  kubectl apply -f patched_k8s.yml
  kubectl rollout status deployment/$PROJECT_NAME

fi