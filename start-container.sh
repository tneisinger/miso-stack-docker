#!/bin/bash

docker run -it -p 3003:3003 --rm --mount type=bind,source=$(pwd),target=/src \
  --name miso_container miso_isomorphic
