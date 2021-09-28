FROM argoproj/argocd:latest

USER root

ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 7.2

RUN apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        openjdk-11-jdk && \
    curl -L https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
    unzip gradle.zip && \
    rm gradle.zip && \
    mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" && \
    ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Switch back to non-root user
USER 999
