# # # Enable the experimental Cluster topology feature.
export CLUSTER_TOPOLOGY=true

# # # Enable the experimental Machine Pool feature
export EXP_MACHINE_POOL=true

# The list of service CIDR, default ["10.128.0.0/12"]
export SERVICE_CIDR=["10.96.0.0/12"]

# The list of pod CIDR, default ["192.168.0.0/16"]
export POD_CIDR=["192.168.0.0/16"]

# The service domain, default "cluster.local"
export SERVICE_DOMAIN="cluster.local"


cluster-init:
	kind create cluster --name=room --config kind-cluster-with-extramounts.yaml
	kubectx kind-room
	clusterctl init --infrastructure docker

workload-cluster-init:
	export SERVICE_CIDR=["10.96.0.0/12"]
	export POD_CIDR=["192.168.0.0/16"]
	clusterctl generate cluster room02 --flavor development \
		--kubernetes-version v1.29.0 \
		--control-plane-machine-count=3 \
		--worker-machine-count=3 \
		> cluster-template.yaml
	kubectl apply -f cluster-template.yaml --dry-run=client
	kubectl apply -f cluster-template.yaml
	kubectl describe cluster room02

workload-cluster-kubeconfig:
	clusterctl get kubeconfig room02 > room02.kubeconfig
	sed -i -e "s/server:.*/server: https:\/\/$(docker port capi-quickstart-lb 6443/tcp | sed "s/0.0.0.0/127.0.0.1/")/g" ./room02.kubeconfig
	sed -i -e "s/certificate-authority-data:.*/insecure-skip-tls-verify: true/g" ./room02.kubeconfig

workload-cluster-cni:
	cilium install --version 1.15.1

clean-up:
	kubectx kind-room
	kubectl delete cluster room02
	kind delete cluster --name=room