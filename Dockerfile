# Dockerfile
FROM --platform=linux/amd64 kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools, GDB, and pwndbg
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        git \
        python3 \
        python3-pip \
        gdb \
        gdb-multiarch \
        build-essential \
        net-tools \
        iproute2 \
        iputils-ping \
        curl \
        wget \
        vim \
        file  \
        strace \
        ltrace \
        tmux \
        sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000
# Create a user for convenient usage
RUN groupadd -g $GID user || true \
    && useradd -m -u $UID -g $GID -s /bin/bash user \
    && echo "user:user" | chpasswd \
    && adduser user sudo \
    && echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER user
WORKDIR /home/user

# Install pwndbg
RUN git clone https://github.com/pwndbg/pwndbg

ENTRYPOINT ["/bin/bash"]