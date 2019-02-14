FROM tehnix/ghcjs-docker:lts-9.21

# Install fswatch so that runner.sh and exeCopier.sh will work
RUN sudo add-apt-repository -y ppa:hadret/fswatch
RUN sudo apt-get -y update
RUN sudo apt-get -y install fswatch

# Upgrade stack to the latest version.  Without this, stack will warn you that
# you should upgrade because certain cabal files were created with a newer
# version of hpack.
RUN stack upgrade

# create the /project dir and set it as the workdir
RUN mkdir -p /project
WORKDIR /project

# Copy everything into the project dir
COPY . /project

# build the frontend and backend
RUN stack build --stack-yaml=frontend/stack.yaml
RUN stack build --stack-yaml=backend/stack.yaml

# When starting this image, run reloader.sh be default.  The reloader.sh script
# will automatically update and restart the server whenever a change is made to
# the source code.
ENTRYPOINT ["./reloader.sh"]
