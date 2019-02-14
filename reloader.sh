#!/bin/bash

# Copy all.js and the server executable into the result/ dir
echo "λ Copying over all.js" \
  && cp $(stack path --stack-yaml=frontend/stack.yaml --local-install-root)/bin/frontend.jsexe/all.js result/static/all.js \
  && echo "λ Copying over the server executable" \
  && cp $(stack path --stack-yaml=backend/stack.yaml --local-install-root)/bin/backend result/bin/server

# Tell stack to rebuild the backend whenever a relevant source file is changed
$(stack --stack-yaml=backend/stack.yaml build --fast --file-watch) &

# Tell stack to rebuild all.js whenever a relevant source file is changed
$(stack --stack-yaml=frontend/stack.yaml build --fast --file-watch) &

# Use fswatch to wait for changes to the files built by stack.
# When a change occurs copy the backend executable to result/bin/ and copy
# all.js to result/static/
./exeCopier.sh &

# Use fs watch to wait for changes to /result/bin/server or
# /result/static/all.js.  When either of these files change, restart
# result/bin/server
./runner.sh bin/server
