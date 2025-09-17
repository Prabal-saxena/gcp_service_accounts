
resource "google_service_account" "gke-service-sa" {
  account_id   = "gke-service-sa"
  display_name = "SA for Kubernetes"
  project = "noble-linker-471623-s6"
  create_ignore_already_exists = true
}

resource "google_service_account_key" "gke_sa_key" {
  service_account_id = google_service_account.gke-service-sa.id
}

resource "local_file" "service_account_key_file" {
  content  = base64decode(google_service_account_key.gke_sa_key.private_key)
  filename = "${path.module}/service_account_key.json"
}

# Upload the local file to GCS
resource "google_storage_bucket_object" "service_account_key" {
  name   = "service_account_key.json"  # File name to store the credentials in GCS
  bucket = "onlineliquorservices_bucket"    # Your GCS bucket name
  source = local_file.service_account_key_file.filename  # Using the local variable

  depends_on = [local_file.service_account_key_file] # Ensure the file is created before uploading
}

resource "google_service_account" "ci-cd-sa" {
  account_id   = "ci-cd-sa"
  display_name = "SA for Ci CD"
  project = "noble-linker-471623-s6"
  create_ignore_already_exists = true
}

resource "google_service_account" "product-service-sa" {
  account_id   = "product-service-sa"
  display_name = "SA for Product Microservice"
  project = "noble-linker-471623-s6"
  create_ignore_already_exists = true
}

resource "google_service_account" "order-service-sa" {
  account_id   = "order-service-sa"
  display_name = "SA for Order Microservice"
  project = "noble-linker-471623-s6"
  create_ignore_already_exists = true
}

resource "google_service_account" "user-service-sa" {
  account_id   = "user-service-sa"
  display_name = "SA for User Service"
  project = "noble-linker-471623-s6"
  create_ignore_already_exists = true
}

terraform {
  backend "gcs" {
    bucket  = "onlineliquorservices_bucket"
    prefix  = "terraform/serviceaccount/tfstate"
  }
}