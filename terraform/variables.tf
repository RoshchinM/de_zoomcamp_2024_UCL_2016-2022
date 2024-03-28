variable "credentials" {
  description = "My credentials"
  default     = "./credentials/zoomcamp-ucl-data-mr-2737b1d969a6.json"
}

variable "Project" {
  description = "Project"
  default     = "zoomcamp-ucl-data-mr"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default = "ucl_main_bucket"
  type        = string
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "The name of the BigQuery dataset"
  type        = string
}
