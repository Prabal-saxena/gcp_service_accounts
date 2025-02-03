
resource "google_service_account" "gke-sa" {
  account_id   = "gke-sa"
  display_name = "SA for Kubernetes"
  project = "spheric-base-448422-q9"
  create_ignore_already_exists = true
}

resource "google_service_account_key" "gke_sa_key" {
  service_account_id = google_service_account.gke-sa.id
}

resource "google_storage_bucket_object" "service_account_key" {
  name   = "service_account_key.json"  # File name to store the credentials in GCS
  bucket = "onlineliquorservices_bucket"    # Your GCS bucket name
  source = google_service_account_key.gke_sa_key.private_key  # Path to the generated key
}

terraform {
  backend "gcs" {
    bucket  = "onlineliquorservices_bucket"
    prefix  = "terraform/serviceaccount/tfstate"
  }
}