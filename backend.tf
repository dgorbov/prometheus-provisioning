terraform {
  backend "s3" {
    region         = "eu-central-1"
    bucket         = "prometheus-tf-state"
    key            = "terraform/main-state"
    dynamodb_table = "tf-state-lock-prometheus-tf-state"
  }
}