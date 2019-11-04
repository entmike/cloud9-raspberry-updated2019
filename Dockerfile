FROM arm32v7/ubuntu
# Use ARM Ubuntu base image
LABEL Mike Howles <mike.howles@gmail.com>
COPY qemu-arm-static /usr/bin
# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    curl \
    libssl-dev \
    apache2-utils \
    git \
    libxml2-dev \
    sshfs \
    python2.7 \
    libevent-dev \
    ncurses-dev \
    locales-all

RUN ln -s /usr/bin/python2.7 /usr/bin/python

# Compile and Install tmux 2.2
RUN curl -sSL -o tmux-2.2.tar.gz https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz && \
    tar -zxf tmux-2.2.tar.gz && \
    cd tmux-2.2 && \
    ./configure && \
    make && make install && \
    cd .. && rm -Rf tmux-2.2 && rm tmux-2.2.tar.gz

# Add cloud9ide user
RUN useradd -m cloud9ide

# Install Docker
RUN curl -sSL https://get.docker.com | sh
RUN usermod -aG docker cloud9ide

#Install NVM
USER cloud9ide
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
USER cloud9ide
COPY ./setupNode.sh ./setupNode.sh
RUN ./setupNode.sh

# Install cloud9ide
RUN git clone https://github.com/c9/core.git /home/cloud9ide/cloud9
RUN /home/cloud9ide/cloud9/scripts/install-sdk.sh

# Update config
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /home/cloud9ide/cloud9/configs/standalone.js

# Add workspace directory
USER root
RUN mkdir /workspace && \
    chown cloud9ide /workspace

# Cleanup apt-get
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Expose ports: Note port 8080 - node is not run as root
EXPOSE 8080
EXPOSE 3000

# Setup entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh
CMD ["/entrypoint.sh"]