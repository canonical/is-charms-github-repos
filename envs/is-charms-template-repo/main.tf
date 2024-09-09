terraform {
  required_version = ">= 1.6.6"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.34.0"
    }
  }
}

provider "github" {}

module "template-repo" {
  source         = "../../modules/template-repo"
  repo_name      = var.repo_name
  template_files = var.template_files
}
