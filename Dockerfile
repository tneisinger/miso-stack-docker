FROM tehnix/ghcjs-docker:lts-9.21

# Install fswatch so that runner.sh and exeCopier.sh will work
RUN sudo add-apt-repository -y ppa:hadret/fswatch
RUN sudo apt-get -y update
RUN sudo apt-get -y install fswatch

# Upgrade stack to the latest version.  Without this, stack will warn you that
# you should upgrade because certain cabal files were created with a newer
# version of hpack.
RUN stack upgrade

# create the /src dir, declare it as a volume, and set it as the workdir
RUN mkdir -p /src
VOLUME /src
WORKDIR /src

# Copy everything into the src dir
COPY . /src

# Build all the parts the project (common, backend, and frontend), copy the
# backend executable to result/bin/server, and copy the frontend's all.js to
# result/static/all.js
RUN ./stack-build.sh

# When starting this image, run reloader.sh be default.  The reloader.sh script
# will automatically update and restart the server whenever a change is made to
# the source code.
ENTRYPOINT ["./reloader.sh"]
