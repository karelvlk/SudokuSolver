#!/bin/bash

IMAGE_NAME="haskell-sudoku"

# Check if the image already exists
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
  echo "Image $IMAGE_NAME does not exist. Building..."
  docker build -t $IMAGE_NAME .
else
  echo "Image $IMAGE_NAME already exists. Skipping build..."
fi

# Run the Docker container
docker run -it --rm -v $(pwd)/assets:/app/assets $IMAGE_NAME
