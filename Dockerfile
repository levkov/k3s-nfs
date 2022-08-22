FROM alpine:3.16.2

RUN apk add --no-cache iptables ip6tables nfs-utils; \
    echo 'hosts: files dns' > /etc/nsswitch.conf

COPY --from=rancher/k3s:v1.22.12-k3s1 /bin /opt/k3s/bin

VOLUME /var/lib/kubelet
VOLUME /var/lib/rancher/k3s
VOLUME /var/lib/cni
VOLUME /var/log

ENV PATH="$PATH:/opt/k3s/bin:/opt/k3s/bin/aux"
ENV CRI_CONFIG_FILE="/var/lib/rancher/k3s/agent/etc/crictl.yaml"

ENTRYPOINT ["/opt/k3s/bin/k3s"]
CMD ["agent"]
