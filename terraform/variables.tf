variable "zone_id" {
  default = "11c7d046cf732e4ab9754e3506493115"
}

variable "account_id" {
  default = "3de13909f2f3b972382054bcbe7f371a"
}

variable "domain" {
  default = "alexcaughey.uk"
}

# export TF_VAR_CLOUDFLARE_S3_ACCESS_KEY_ID = xxxx
variable "CLOUDFLARE_S3_ACCESS_KEY_ID" {
  default = null
  type    = string
}

# export TF_VAR_CLOUDFLARE_S3_SECRET_ACCESS_KEY = xxxx
variable "CLOUDFLARE_S3_SECRET_ACCESS_KEY" {
  default = null
  type    = string
}
