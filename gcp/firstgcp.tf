resource "google_compute_instance" "development" {
  name         = "development"
  machine_type = "n1-standard-1"
  zone         = "us-east1-d"
  description  = "mass-remote"
  tags         = ["development", "mass"]

  disk {
    image = "ubuntu-os-cloud/ubuntu-1404-lts"
  }

  // Local SSD disk
  disk {
    type        = "local-ssd"
    scratch     = true
    auto_delete = true
  }

  network_interface {
    subnetwork = "development"
  }

#  service_account {
#    scopes = ["userinfo-email", "compute-ro", "storage-ro", "bigquery", "monitoring"]
#  }
#
#  scheduling {
#    on_host_maintenance = "MIGRATE"
#    automatic_restart   = true
#  }
}
