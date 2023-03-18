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

variable "admin" {
  type = map(list(string))

  description = "ACL for teams"
}

variable "readonly" {
  type = map(list(string))

  description = "ACL for teams"
}

variable "readwrite" {
  type = map(list(string))

  description = "ACL for teams"
}

# variable "repository_name" {
#   type = string

#   validation {
#     condition     = length(var.repository_name) > 0
#     error_message = "Repository name should not be blank."
#   }

#   description = "Repository name."

#   nullable = false
# }

# variable "team_name" {
#   type = string

#   validation {
#     condition     = length(var.team_name) > 0
#     error_message = "Team name should not be blank."
#   }

#   description = "Team name."

#   nullable = false
# }
