# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM php:8.0.9-apache as builder

CMD ["apache2-foreground"]

FROM builder as dev-envs

RUN apt-get update && apt-get install -y --no-install-recommends git unzip

RUN useradd -s /bin/bash -m vscode && groupadd docker && usermod -aG docker vscode

WORKDIR /usr/local/src

RUN git clone https://github.com/Kan-Kzeit/particle2dx.git && mv -v /usr/local/src/particle2dx/* /var/www/html/

# install Docker tools (cli, buildx, compose)
COPY --from=gloursdocker/docker / /

WORKDIR /var/www/html

CMD ["apache2-foreground"]