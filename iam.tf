resource "google_service_account" "gke_sa" {
  account_id   = "${var.gke_cluster_name}-gke-sa"
  display_name = "Custom GKE service account"
}


resource "google_project_iam_member" "gke_sa" {
  project = var.project_id
  count   = length(var.iam_roles_list)
  role    = var.iam_roles_list[count.index]
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}


# Workload Identity

resource "google_service_account" "wi_gsa" {
  account_id   = "simple-wi-gsa"
  display_name = "Workload Identity Google service account"
}

resource "google_project_iam_member" "wi_gsa" {
  project = var.project_id
  count   = length(var.wi_iam_roles_list)
  role    = var.wi_iam_roles_list[count.index]
  member  = "serviceAccount:${google_service_account.wi_gsa.email}"
}
