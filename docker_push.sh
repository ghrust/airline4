#!/bin/bash

sudo docker login --username $HEROKU_DOCKER_USERNAME --password $HEROKU_AUTH_TOKEN registry.heroku.com
sudo docker tag $HEROKU_APP_NAME:latest registry.heroku.com/$HEROKU_APP_NAME/web
if [ $TRAVIS_BRANCH == "master" ] && [ $TRAVIS_PULL_REQUEST == "false" ]; then sudo docker push registry.heroku.com/$HEROKU_APP_NAME/web; fi

chmod +x heroku_container_release.sh
sudo chown $USER:docker ~/.docker
sudo chown $USER:docker ~/.docker/config.json
sudo chmod g+rw ~/.docker/config.json

./heroku_container_release.sh
