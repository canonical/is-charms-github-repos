terraform {
  required_version = ">= 1.6.6"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}

resource "github_repository" "templated" {
  name        = var.repo_name
  archived    = var.archived
  description = format("%s - charm repository.", var.repo_name)

  visibility = "public"

  allow_merge_commit     = false
  allow_rebase_merge     = false
  delete_branch_on_merge = true

  has_issues    = true
  has_downloads = true
  has_projects  = true
  has_wiki      = true

  dynamic "template" {
    for_each = var.template_repo_enabled == true ? toset([1]) : toset([])
    content {
      include_all_branches = true
      owner                = var.template_repo_owner
      repository           = var.template_repo_name
    }
  }
}

resource "github_branch_protection" "templated-protect-main" {
  repository_id = var.repo_name
  # also accepts repository name
  # repository_id  = github_repository.example.name

  pattern = "main"

  enforce_admins = false

  require_signed_commits          = true
  require_conversation_resolution = true
  required_linear_history         = true

  required_status_checks {
    contexts = var.required_status_checks
    strict   = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 2
    restrict_dismissals             = false
  }
}

resource "github_branch_protection" "templated-protect-track" {
  repository_id = var.repo_name
  # also accepts repository name
  # repository_id  = github_repository.example.name

  pattern = "track/**"

  enforce_admins = false

  require_signed_commits          = true
  require_conversation_resolution = true
  required_linear_history         = true

  required_status_checks {
    contexts = var.required_status_checks
    strict   = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 2
    restrict_dismissals             = false
  }
}

resource "github_branch_protection" "templated-protect-files" {
  repository_id = var.repo_name

  pattern = "feature/template-files"

  allows_deletions = false

  require_signed_commits          = true
  require_conversation_resolution = false
}

resource "github_branch_protection" "templated-protect-catchall" {
  repository_id = var.repo_name
  # also accepts repository name
  # repository_id  = github_repository.example.name

  pattern = "**/**"

  allows_deletions = true

  require_signed_commits = true

  require_conversation_resolution = false

}

resource "github_branch" "template-files" {
  repository = var.repo_name
  branch     = "feature/template-files"
}

resource "github_repository_file" "template-files" {
  for_each            = toset(var.template_files)
  repository          = var.repo_name
  branch              = "feature/template-files"
  file                = each.value
  content             = file("${path.module}/files/${each.value}")
  commit_message      = format("chore(files): %s managed by Terraform", each.value)
  overwrite_on_create = true

  depends_on = [
    github_branch.template-files
  ]
}

resource "github_team_repository" "is-charms" {
  repository = var.repo_name
  team_id    = "is-charms"
  permission = "maintain"
}

resource "github_team_repository" "is-devops-leadership" {
  repository = var.repo_name
  team_id    = var.admin_team
  permission = "admin"
}

resource "github_repository_webhook" "github-actions-dashboard-webhook" {
  repository = var.repo_name

  configuration {
    url          = "https://gh-actions-exporter.canonical.com/gh_event"
    content_type = "json"
    insecure_ssl = false
    secret       = var.github_actions_dashboard_secret
  }

  active = true

  events = ["workflow_run", "workflow_job"]
}

resource "github_actions_secret" "charmhub_token" {
  repository      = var.repo_name
  secret_name     = "CHARMHUB_TOKEN"
  plaintext_value = var.charmhub_token_secret
}

resource "github_actions_secret" "repo_access_token" {
  repository      = var.repo_name
  secret_name     = "REPO_ACCESS_TOKEN"
  plaintext_value = var.repo_access_token_secret
}

resource "github_actions_secret" "jira_url" {
  repository      = var.repo_name
  secret_name     = "JIRA_URL"
  plaintext_value = var.jira_url_secret
}
