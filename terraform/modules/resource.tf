# data "github_organization" "MyOrg" {
#   name = var.organization_name
# }

resource "github_branch_protection" "ProtectionRules" {

  for_each = {
    for index, item in var.repo_list :
    item => item
  }

  repository_id = each.value
  pattern       = "main"

  required_pull_request_reviews {
    require_code_owner_reviews = true
  }

  lock_branch = true

  required_status_checks {
    strict = true
  }

}

resource "github_team_repository" "access_team_repo" {
  for_each = {
    for index, item in var.team_repo :
    "${item.team} ${item.repo}" => item...
  }

  team_id    = each.value[0].team
  repository = each.value[0].repo
  permission = var.permission_rule
}

resource "github_repository_collaborator" "repo_collaborator" {
  for_each = {
    for index, item in var.user_repo :
    "${item.user} ${item.repo}" => item...
  }

  username   = each.value[0].user
  repository = each.value[0].repo
  permission = var.permission_rule
}

resource "github_repository_autolink_reference" "servicedesk_autolink" {
  # count = var.team_name == "cit" ? 1 : 0

  for_each = var.team_name == "cit" ? {
    for index, item in var.repo_list :
    item => item
  } : {}

  repository = "repo-2"

  key_prefix = "DEVOPS-"

  target_url_template = "https://servicedeskdev.barco.com/browse/DEVOPS?query=<num>"
}

resource "github_repository_autolink_reference" "itrack_autolink" {
  # count = var.team_name == "cit" ? 1 : 0

  for_each = var.team_name == "cit" ? {
    for index, item in var.repo_list :
    item => item
  } : {}

  repository = "repo-1"

  key_prefix = "NET0033-"

  target_url_template = "https://itrack.barco.com/browse/NET0033?query=<num>"
}








#######################
#   REPOSITORY CODE   #
#######################

# data "github_repository" "MyRepo" {
#   full_name = "${data.github_organization.MyOrg.orgname}/${var.repository_name}"
# }

# output "repo_data" {
#   value = data.github_repository.MyRepo
# }

# resource "github_branch_protection" "ProtectionRules" {
#   count = var.enforce_rules ? 1 : 0

#   repository_id = data.github_repository.MyRepo.name
#   pattern       = data.github_repository.MyRepo.default_branch

#   required_pull_request_reviews {
#     require_code_owner_reviews = true
#   }

#   lock_branch = true

#   required_status_checks {
#     strict = true
#   }

# }

#######################
#       TESTING       #
#######################

# data "github_organization" "MyOrg" {
#   name = var.organization_name
# }

# output "org_data" {
#   value = data.github_organization.MyOrg
# }

# resource "github_repository" "MyRepo" {
#   name        = var.repository_name
#   description = "Github repository to practically use terraform commands."
#   auto_init   = true
#   visibility  = "public"

#   has_issues = true
# }

# resource "github_repository_file" "MyFile" {
#   repository          = data.github_repository.MyRepo.name
#   branch              = "master"
#   file                = "app.py"
#   content             = "print('variables.tf')"
#   commit_message      = "Init Commit"
#   overwrite_on_create = true
# }
