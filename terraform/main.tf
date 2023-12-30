terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

data "terraform_remote_state" "state" {
  backend = "s3"

  config = {
    bucket    = "terraform"
    key       = "terraform/terraform.tfstate"
    endpoints = { s3 = "https://3de13909f2f3b972382054bcbe7f371a.r2.cloudflarestorage.com" }
    region    = "us-east-1"

    access_key                  = "${var.CLOUDFLARE_S3_ACCESS_KEY_ID}"
    secret_key                  = "${var.CLOUDFLARE_S3_SECRET_ACCESS_KEY}"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}

provider "cloudflare" {
  # token pulled from $CLOUDFLARE_API_TOKEN
}

resource "cloudflare_record" "www" {
  zone_id = var.zone_id
  name    = "www"
  value   = "203.0.113.10"
  type    = "A"
  proxied = true
}