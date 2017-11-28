Create and Manager kubernetes cluster

gcloud container clusters create ravis-k8scluster-1 --zone us-central1-a --additional-zones us-central1-b,us-central1-c
gcloud container clusters create ravis-k8scluster-1 --zone us-central1-a 

(verify API is enabled, and Billing is enabled for the API)
(verify quota is available on all zones)

Accessing a Container Engine cluster requires the kubernetes commandline
client [kubectl]. To install, run
  $ gcloud components install kubectl


gcloud components install kubectl 
gcloud compute networks subnets list

Delete a Kubernetes Cluster
gcloud container clusters delete ravis-k8scluster-1 --zone us-central1-a

Describe a Cluster
gcloud container clusters describe  ravis-k8scluster-2 --zone us-central1-a


gcloud container clusters list
gcloud container clusters get-credentials  ravis-k8scluster-2

kubectl config set-cluster ravis-k8scluster-2
Cluster "ravis-k8scluster-2" set.

gcloud container get-server-config --zone us-central1-a




List and delete Projects
gcloud projects list
gcloud projects delete "strategic-arc-153221"


KUBECTL commands
kubectl config get-clusters
NAME
gke_ravis-kcluster-1_us-central1-a_ravis-k8scluster-2
ravis-k8scluster-2

kubectl config current-context
gke_ravis-kcluster-1_us-central1-a_ravis-k8scluster-2

kubectl config get-clusters
kubectl config current-context
kubectl cluster-info
kubectl describe nodes
kubectl describe pods -
kubectl get pods --all-namespaces -
kubectl config view



gcloud container clusters create secondary-delete --network worker-space --subnetwork worker-space-default --zone us-central1

gcloud container clusters delete ravis-k8scluster-2 --zone us-central1-a



Terraform for Google Cloud Container Cluster

I added this to the script in the adron-infrastructure branch of my repo here.

resource "google_container_cluster" "development" {
  name = "development-systems"
  zone = "us-west1-b"
  initial_node_count = 3

  master_auth {
    username = "someusername"
    password = "willchange"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}
