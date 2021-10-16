FROM argoproj/argocd:latest

USER root

ENV NODE_HOME /opt/node
ENV NODE_VERSION 14.18.1
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 7.2

RUN apt-get update && \
    apt-get install -y \
        curl \
        tar \
        unzip \
        openjdk-11-jdk && \
    curl -L https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
    unzip gradle.zip && \
    rm gradle.zip && \
    mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" && \
    ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle && \
    curl -L https://nodejs.org/dist/v$NODE_VERSION/node-v${NODE_VERSION}-linux-x64.tar.xz -o node.tar.xz && \
    tar -xf node.tar.xz && \
    rm node.tar.xz && \
    mv "node-v${NODE_VERSION}-linux-x64" "${NODE_HOME}" && \
    ln --symbolic "${NODE_HOME}/bin/node" /usr/bin/node && \
    ln --symbolic "${NODE_HOME}/bin/npm" /usr/bin/npm && \
    npm -g install npm && \
    npm -g install cdk8s-cli && \
    ln --symbolic "${NODE_HOME}/bin/cdk8s" /usr/bin/cdk8s && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Switch back to non-root user
USER 999
