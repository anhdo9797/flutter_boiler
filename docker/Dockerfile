FROM ubuntu:20.04

ENV JDK_VERSION=11
ENV BUILD_TOOL_VERSION=30.0.1
ENV TARGET_SDK_VERSION=30
ENV ANDROID_SDK_TOOK_VERSION=9123335
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt install -y git \
    build-essential \
    libssl1.1 \
    wget \
    unzip \
    zip \
    tzdata \
    locales \
    zlib1g-dev \ 
    libssl-dev \
    curl \
    libyaml-dev \
    openjdk-${JDK_VERSION}-jdk 

# Set up Ruby
ARG RUBY_VERSION=3.2.0
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

ENV PATH "/root/.rbenv/bin:/root/.rbenv/plugins/ruby-build/bin:$PATH"

RUN echo 'eval "$(/root/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc && \
    exec $SHELL && \
    /root/.rbenv/plugins/ruby-build/install.sh && \
    rbenv install ${RUBY_VERSION} && \
    rbenv global ${RUBY_VERSION}

ENV PATH "/root/.rbenv/shims:$PATH"
RUN gem install bundler && \
    gem install fastlane

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

WORKDIR /sdk

# Prepare Android directories and system variables
# https://stackoverflow.com/a/70631987/14539746
RUN mkdir -p android-sdk-linux/cmdline-tools
ENV ANDROID_SDK_ROOT /sdk/android-sdk-linux
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN cd android-sdk-linux/cmdline-tools && \ 
    wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOK_VERSION}_latest.zip
RUN cd android-sdk-linux/cmdline-tools && unzip android-sdk.zip && rm android-sdk.zip
RUN cd android-sdk-linux/cmdline-tools && mv cmdline-tools version && \
    yes | version/bin/sdkmanager "platforms;android-${TARGET_SDK_VERSION}" && \
    yes | version/bin/sdkmanager "build-tools;${BUILD_TOOL_VERSION}" && \
    yes | version/bin/sdkmanager "platform-tools" && \
    yes | version/bin/sdkmanager --licenses > /dev/null

ENV JAVA_HOME /usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64
ENV PATH "$PATH:$ANDROID_SDK_ROOT/platform-tools/:$JAVA_HOME/bin"

# # Download Flutter SDK
ARG FLUTTER_VERSION=3.3.10
RUN git clone https://github.com/flutter/flutter.git

ENV PATH "$PATH:/sdk/flutter/bin"
ENV FLUTTER_ROOT=/sdk/flutter
ENV FLUTTER_HOME=/sdk/flutter

# Run basic check to download Dark SDK
RUN flutter doctor
RUN echo "Docker running..."

USER root
WORKDIR /home/project