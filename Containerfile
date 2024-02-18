FROM ghcr.io/ublue-os/fedora-distrobox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="deverett@gmail.com"

COPY extra-packages /
RUN dnf update -y && dnf upgrade -y
RUN grep -v '^#' /extra-packages | xargs dnf install -y && rm /extra-packages

RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update

#RUN ls -l /etc/locale.gen
#RUN sed -i 's/^#\s\+\(en_AU\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
#RUN locale-gen

RUN echo 'GOPATH=/usr/local/go' >> /etc/environment
RUN curl -sfL https://go.dev/dl/go1.22.0.linux-amd64.tar.gz | tar -C /usr/local -zxf -
RUN go install github.com/go-delve/delve/cmd/dlv@latest
