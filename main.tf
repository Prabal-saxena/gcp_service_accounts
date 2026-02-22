
resource "google_service_account" "ci-cd-sa" {
  account_id   = "ci-cd-sa"
  display_name = "SA for Ci CD"
  project = var.project
  create_ignore_already_exists = true
}

resource "google_service_account" "product-service-sa" {
  account_id   = "product-service-sa"
  display_name = "SA for Product Microservice"
  project = var.project
  create_ignore_already_exists = true
}

resource "google_service_account" "order-service-sa" {
  account_id   = "order-service-sa"
  display_name = "SA for Order Microservice"
  project = var.project
  create_ignore_already_exists = true
}

resource "google_service_account" "user-service-sa" {
  account_id   = "user-service-sa"
  display_name = "SA for User Service"
  project = var.project
  create_ignore_already_exists = true
}

resource "google_service_account" "ecom-helm-sa" {
  account_id   = "ecom-helm-sa"
  display_name = "SA for Helm Service"
  project = var.project
  create_ignore_already_exists = true
}

resource "google_service_account" "sql-proxy-sa" {
  account_id   = "sql-proxy-sa"
  display_name = "SA for pgsql proxy"
  project = var.project
  create_ignore_already_exists = true
}

terraform {
  backend "gcs" {
    bucket  = "onlineliquorservicesbucket"
    prefix  = "terraform/serviceaccount/tfstate"
  }
}
