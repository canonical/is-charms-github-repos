variable "admin_team" {
  description = "Team administering the repository"
  type        = string
}

variable "archived" {
  description = "Whether the repository is archived"
  type        = bool
}

variable "github_actions_dashboard_secret" {
  description = "Secret used by the GitHub Actions Dashboard webhook."
  type        = string
  sensitive   = true
}

variable "jira_url_secret" {
  description = "Jira URL for github to sync issues."
  type        = string
}

variable "repo_access_token_secret" {
  description = "GitHub token to update libraries and other code changes. Ideally from a bot account."
  type        = string
  sensitive   = true
}

variable "repo_name" {
  description = "Repo name to use with the selected template."
  type        = string
}

variable "required_status_checks" {
  description = "Required status checks for the repository"
  type        = set(string)
}

variable "template_files" {
  description = "A set of files to manage in terraform."
  type        = set(string)
}

variable "template_repo_enabled" {
  description = "Whether to use a template repository when creating a repo."
  type        = bool
}

variable "template_repo_name" {
  description = "Repo name of the template repository."
  type        = string
}

variable "template_repo_owner" {
  description = "Repo owner of the template repository."
  type        = string
}
