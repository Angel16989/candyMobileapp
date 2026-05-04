ARG FLUTTER_VERSION=3.41.9

FROM ubuntu:24.04 AS flutter-sdk
ARG FLUTTER_VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        libglu1-mesa \
        unzip \
        xz-utils \
        zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fL \
      "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
      -o /tmp/flutter.tar.xz \
    && mkdir -p /opt \
    && tar -xf /tmp/flutter.tar.xz -C /opt \
    && rm /tmp/flutter.tar.xz

RUN git config --global --add safe.directory /opt/flutter \
    && flutter --disable-analytics \
    && flutter config --enable-web \
    && flutter precache --web

WORKDIR /app

FROM flutter-sdk AS deps
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

FROM deps AS verify
COPY . .
RUN flutter test

FROM deps AS build-web
COPY . .
RUN flutter build web --release

FROM nginx:1.27-alpine AS web
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build-web /app/build/web /usr/share/nginx/html
EXPOSE 80
