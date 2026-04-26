FROM ghcr.io/cirruslabs/flutter:stable

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git curl unzip xz-utils zip libglu1-mesa \
    clang cmake ninja-build pkg-config \
    libgtk-3-dev liblzma-dev \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --depth=1 https://github.com/krille-chan/fluffychat

WORKDIR /app/fluffychat

RUN flutter config --enable-linux-desktop \
    && flutter config --enable-web \
    && flutter config --enable-android

RUN flutter doctor

RUN flutter pub get

COPY pubspec.yaml pubspec.lock /app/fluffychat/

RUN flutter precache --android --linux --web

# RUN flutter build apk --debug || true
# RUN flutter build linux --debug || true
# RUN flutter build web || true

CMD ["/bin/bash"]
