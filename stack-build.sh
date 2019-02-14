#!/usr/bin/env bash

nodePath=$(which node)
if [[ $nodePath == *"nodenv/shims"* ]]; then
  nodePath=$(nodenv which node)
fi

echo "λ Building the frontend..." \
  && stack build --stack-yaml=frontend/stack.yaml \
  && echo "λ Copying over all.js" \
  && cp $(stack path --stack-yaml=frontend/stack.yaml --local-install-root)/bin/frontend.jsexe/all.js result/static/all.js \
  && echo "" \
  && echo "λ Building the backend..." \
  && stack build --stack-yaml=backend/stack.yaml \
  && echo "λ Done"
