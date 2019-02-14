#!/usr/bin/env bash

echo "λ Building the backend..." \
  && stack build --stack-yaml=backend/stack.yaml \
  && cp $(stack path --stack-yaml=backend/stack.yaml --local-install-root)/bin/backend result/bin/server \
  && echo "λ Done"
