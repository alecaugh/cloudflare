terraform {
  required_version = "1.6.6"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }

  backend "s3" {
    bucket    = "terraform"
    key       = "nextjs-blog/terraform.tfstate"
    endpoints = { s3 = "https://3de13909f2f3b972382054bcbe7f371a.r2.cloudflarestorage.com" }
    region    = "us-east-1"

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

resource "cloudflare_record" "terraform_managed_resource_0b08a97974b4da68bcf1eac135be3f9f" {
  name    = "alexcaughey.uk"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "nextjs-app-dfu.pages.dev"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c0cd8a8958b4a5dbfcc1fb778a15563c" {
  name     = "alexcaughey.uk"
  priority = 88
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route3.mx.cloudflare.net"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_148570af40deaaf2d0519a16545c3aa5" {
  name     = "alexcaughey.uk"
  priority = 37
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route2.mx.cloudflare.net"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_6b25b8f3ce3435d75a5b7f6c4714c6e3" {
  name     = "alexcaughey.uk"
  priority = 82
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route1.mx.cloudflare.net"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_60d17b84f28fe53bf8da7eb17c0b4503" {
  name    = "alexcaughey.uk"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "\"v=spf1 include:_spf.mx.cloudflare.net ~all\""
  zone_id = var.zone_id
}

resource "cloudflare_pages_domain" "website" {
  account_id   = var.account_id
  project_name = "nextjs-app"
  domain       = "alexcaughey.uk"
}

# Pages project managing all configs
resource "cloudflare_pages_project" "blog" {
  account_id        = var.account_id
  name              = "nextjs-blog"
  production_branch = "main"

  source {
    type = "github"
    config {
      owner                         = "alecaugh"
      repo_name                     = "nextjs-blog"
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "all"
      preview_branch_includes       = ["*"]
    }
  }

  build_config {
    build_command   = "npx @cloudflare/next-on-pages@1"
    destination_dir = ".vercel/output/static"
    root_dir        = "nextjs-blog"
  }

  deployment_configs {
    preview {
      compatibility_date  = "2023-12-27"
      compatibility_flags = ["nodejs_compat"]
      fail_open           = true
      usage_model         = "standard"
    }
    production {
      compatibility_date  = "2023-12-27"
      compatibility_flags = ["nodejs_compat"]
      fail_open           = true
      usage_model         = "standard"
    }
  }
}

resource "cloudflare_r2_bucket" "terraform" {
  account_id = var.account_id
  name       = "terraform"
  location   = "WEUR"
}

/* resource "cloudflare_pages_project" "website" {
  account_id        = var.account_id
  name              = "nextjs-app"
  production_branch = "main"

  source {
    type = "github"
    config {
      owner                         = "alecaugh"
      repo_name                     = "cloudflare"
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "all"
      preview_branch_includes       = ["*"]
    }
  }

  build_config {
    build_command   = "npx @cloudflare/next-on-pages@1"
    destination_dir = ".vercel/output/static"
    root_dir        = "nextjs-app"
  }

  deployment_configs {
    preview {
      compatibility_date  = "2023-12-27"
      compatibility_flags = ["nodejs_compat"]
      fail_open           = true
      usage_model         = "standard"
    }
    production {
      compatibility_date  = "2023-12-27"
      compatibility_flags = ["nodejs_compat"]
      fail_open           = true
      usage_model         = "standard"
    }
  }
} */
