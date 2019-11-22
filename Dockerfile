ARG GIT_REF=master
FROM k8s.gcr.io/debian-base:v1.0.0 as builder

WORKDIR /dsvpn

RUN set -x \
    && clean-install clang git ca-certificates make \
    && git clone --depth=1 https://github.com/jedisct1/dsvpn /dsvpn  \
    && git checkout ${GIT_REF} && make

# For security, we use kubernetes community maintained debian base image.
# https://github.com/kubernetes/kubernetes/blob/master/build/debian-base/
FROM k8s.gcr.io/debian-base:v1.0.0

COPY --from=builder /dsvpn/dsvpn /usr/local/bin/dsvpn

# Keep packages up to date and install packages for our needs.
RUN set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && clean-install \
    util-linux \
    iptables \
    net-tools \
    procps \
    iproute2

ENTRYPOINT ["/usr/local/bin/dsvpn"]
