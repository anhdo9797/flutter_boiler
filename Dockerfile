FROM ubuntu:22.04

ARG FLUTTER_VERSION=3.3.9
ARG JDK_VERSION=11
ARG BUILD_TOOL_VERSION=32.0.0
ARG TARGET_SDK_VERSION=31
ARG ANDROID_SDK_TOOK_VERSION=9123335
ARG RUBY_VERSION=3.2.0

RUN apt-get update && \
    apt install -y git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-${JDK_VERSION}-jdk \
    wget \
    curl \
    # packages for building ruby: https://hub.docker.com/r/instructure/rvm/dockerfile
    procps \
    ca-certificates \
    gnupg2 \
    make \
    autoconf \
    automake \
    bison \
    g++ \
    gawk \
    imagemagick \
    libbz2-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libffi-dev \
    libgdbm-dev \
    libglib2.0-dev \
    libgmp-dev \
    libjpeg-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmysqlclient-dev \
    libncurses-dev \
    libncurses5-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    make \
    patch \
    sqlite3 \
    zlib1g-dev \
    gnupg2 \
    libtool \
    openssl \
    build-essential --no-install-recommends && \
    apt-get clean

# Set up new user
RUN useradd -ms /bin/bash developer
USER developer

RUN gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB    || \
    gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB || \
    gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -

RUN curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail stable \
    && echo 'bundler' >> /home/developer/.rvm/gemsets/global.gems \
    && echo 'rvm_silence_path_mismatch_check_flag=1' >> ~/.rvmrc 

SHELL ["/bin/bash", "-lc" ]
CMD ["/bin/bash", "-l"]

RUN rvm install ${RUBY_VERSION} && \
    rvm use --default ${RUBY_VERSION} >> dev/null

RUN gem install bundler && gem install fastlane
RUN ruby --version
RUN gem --version

WORKDIR /home/developer

# Prepare Android directories and system variables
# https://stackoverflow.com/a/70631987/14539746
RUN mkdir -p android-sdk-linux/cmdline-tools
ENV ANDROID_SDK_ROOT /home/developer/android-sdk-linux
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN cd android-sdk-linux/cmdline-tools && \ 
    wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOK_VERSION}_latest.zip
RUN cd android-sdk-linux/cmdline-tools && unzip android-sdk.zip && rm android-sdk.zip
RUN cd android-sdk-linux/cmdline-tools && mv cmdline-tools version
RUN cd android-sdk-linux/cmdline-tools && yes | version/bin/sdkmanager "platforms;android-${TARGET_SDK_VERSION}" >/dev/null
RUN cd android-sdk-linux/cmdline-tools && yes | version/bin/sdkmanager "platform-tools" >/dev/null
RUN cd android-sdk-linux/cmdline-tools &&  yes | version/bin/sdkmanager "build-tools;${BUILD_TOOL_VERSION}" >/dev/null
RUN cd android-sdk-linux/cmdline-tools &&  yes | version/bin/sdkmanager --licenses

ENV PATH "$PATH:$ANDROID_SDK_ROOT/platform-tools/"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor
RUN echo "Docker running..."