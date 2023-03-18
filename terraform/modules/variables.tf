variable "github_auth_token" {
  type      = string
  default   = "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"
  sensitive = true
}

variable "organization_name" {
  type = string

  validation {
    condition     = length(var.organization_name) > 0
    error_message = "Organization name should not be blank."
  }

  description = "Organization name."

  nullable = false
}

variable "team_name" {
  type = string

  description = "Name of the team."
}

# variable "enforce_rules" {
#   type = bool

#   description = "Enforce rules on repository? (true / false)."
# }

variable "team_repo" {
  type = list(any)

  description = "ACL for teams"
}

variable "permission_rule" {
  type = string

  description = "Permission of team members regarding the repository. (Admin, pull, push)"
}

variable "repo_list" {
  type = list(string)

  default = []

  description = "list of all repositories to apply the branch protection rules on."
}

variable "user_repo" {
  type = list(any)

  description = "list of all users to associate with the repositories."
}
