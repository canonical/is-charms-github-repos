terraform {
  required_version = ">= 1.6.6"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.34.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.2.0"
    }
  }
}

provider "vault" {
  address = "https://vault.admin.canonical.com:8200"
  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.login_approle_role_id
      secret_id = var.login_approle_secret_id
    }
  }
}

data "vault_generic_secret" "is-charms-repo" {
  path = "secret/prodstack5/roles/prod-is-charms-repos/is-charms-repo"
}

module "templated-repos" {
  for_each                        = { for repo in var.repositories : repo.id => repo }
  source                          = "../../modules/templated-repo"
  admin_team                      = "is-devops-leadership"
  archived                        = each.value.archived
  github_actions_dashboard_secret = data.vault_generic_secret.is-charms-repo.data["github_actions_dashboard_secret"]
  jira_url_secret                 = data.vault_generic_secret.is-charms-repo.data["jira_url"]
  repo_access_token_secret        = data.vault_generic_secret.is-charms-repo.data["repo_access_token"]
  repo_name                       = each.value.id
  required_status_checks          = each.value.required_status_checks
  template_files                  = each.value.template_files
  template_repo_enabled           = each.value.template_repo_enabled
  template_repo_name              = each.value.template_repo_name
  template_repo_owner             = each.value.template_repo_owner
}
