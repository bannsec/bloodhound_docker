FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive

# LD_LIBRARY_PATH=$PWD ./BloodHound --no-sandbox
# libatk1.0-0 libatk-bridge2.0-0 libgdk-pixbuf2.0-0 libgtk-3-0 libgbm1 libxss1

RUN apt update && apt dist-upgrade -y && \
    apt install -y wget gnupg unzip npm libatk1.0-0 libatk-bridge2.0-0 libgdk-pixbuf2.0-0 libgtk-3-0 libgbm1 libxss1 && \
    wget -O- https://debian.neo4j.com/neotechnology.gpg.key | apt-key add - && \
    echo 'deb https://debian.neo4j.com stable latest' >> /etc/apt/sources.list.d/neo4j.list && \
    apt update && \
    echo "neo4j-enterprise neo4j/question select I ACCEPT" | debconf-set-selections && \
    echo "neo4j-enterprise neo4j/license note" | debconf-set-selections && \
    apt install -y neo4j-enterprise && \
    BHPATH=`wget -O- -q https://github.com/BloodHoundAD/BloodHound/releases/latest | grep tar.gz | cut -f 2 -d '"' | head -1` && \
    mkdir -p /opt && cd /opt && \
    wget -O bh.tar.gz https://github.com/$BHPATH && tar xf bh.tar.gz && rm bh.tar.gz && cd * && \
    npm install && npm run linuxbuild && \
    cd BloodHound-linux-x64 && ln -s $PWD/BloodHound /BloodHound

COPY run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT "/run.sh"
