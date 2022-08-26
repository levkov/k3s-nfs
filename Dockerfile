FROM alpine:3.16.2

RUN apk add --no-cache iptables ip6tables nfs-utils; \
    echo 'hosts: files dns' > /etc/nsswitch.conf

ARG VERSION="dev"
COPY --from=rancher/k3s:v1.22.13-k3s1 /bin /bin

RUN mkdir -p /etc && \
    echo 'hosts: files dns' > /etc/nsswitch.conf && \
    echo "PRETTY_NAME=\"K3s ${VERSION}\"" > /etc/os-release && \
    chmod 1777 /tmp
VOLUME /var/lib/kubelet
VOLUME /var/lib/rancher/k3s
VOLUME /var/lib/cni
VOLUME /var/log
ENV PATH="$PATH:/bin/aux"
ENV CRI_CONFIG_FILE="/var/lib/rancher/k3s/agent/etc/crictl.yaml"
ENTRYPOINT ["/bin/k3s"]
CMD ["agent"]
