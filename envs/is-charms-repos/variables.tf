variable "repositories" {
  description = "Repo names to use with the selected template."
  type = set(object({
    id                              = string
    archived                        = optional(bool, false)
    github_actions_dashboard_secret = optional(string)
    jira_url_secret                 = optional(string)
    repo_access_token_secret        = optional(string)
    required_status_checks = optional(set(string), [
      "integration-tests / Required Integration Test Status Checks",
      "unit-tests / Required Test Status Checks",
    ])
    template_files        = optional(set(string), ["renovate.json"])
    template_repo_enabled = optional(bool, false)
    template_repo_name    = optional(string, "is-charms-template-repo")
    template_repo_owner   = optional(string, "canonical")
  }))
}

variable "login_approle_role_id" {
  description = "Approle Role ID"
  type        = string
  validation {
    condition     = var.login_approle_role_id != null
    error_message = "No value set for login_approle_role_id: Check that TF_VAR_LOGIN_APPROLE_ROLE_ID has been exported."
  }
}


variable "login_approle_secret_id" {
  description = "Approle Secret ID"
  type        = string
  validation {
    condition     = var.login_approle_secret_id != null
    error_message = "No value set for login_approle_secret_id: Check that TF_VAR_LOGIN_APPROLE_SECRET_ID has been exported."
  }
}
