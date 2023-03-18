locals {
  repo_list = toset(concat(sort(lookup(var.admin, "repos")), sort(lookup(var.readonly, "repos")), sort(lookup(var.readwrite, "repos"))))

  admin_team_repo_list = (sort(lookup(var.admin, "teams")) == null ? [] : flatten([
    for team in sort(lookup(var.admin, "teams")) : [
      for repo in sort(lookup(var.admin, "repos")) : {
        team = team
        repo = repo
      }
    ]
  ]))

  readonly_team_repo_list = (sort(lookup(var.readonly, "teams")) == null ? [] : flatten([
    for team in sort(lookup(var.readonly, "teams")) : [
      for repo in sort(lookup(var.readonly, "repos")) : {
        team = team
        repo = repo
      }
    ]
  ]))

  readwrite_team_repo_list = (sort(lookup(var.readwrite, "teams")) == null ? [] : flatten([
    for team in sort(lookup(var.readwrite, "teams")) : [
      for repo in sort(lookup(var.readwrite, "repos")) : {
        team = team
        repo = repo
      }
    ]
  ]))

  admin_user_repo_list = (sort(lookup(var.admin, "users")) == null ? [] : flatten([
    for user in sort(lookup(var.admin, "users")) : [
      for repo in sort(lookup(var.admin, "repos")) : {
        user = user
        repo = repo
      }
    ]
  ]))

  readonly_user_repo_list = (sort(lookup(var.readonly, "users")) == null ? [] : flatten([
    for user in sort(lookup(var.readonly, "users")) : [
      for repo in sort(lookup(var.readonly, "repos")) : {
        user = user
        repo = repo
      }
    ]
  ]))

  readwrite_user_repo_list = (sort(lookup(var.readwrite, "users")) == null ? [] : flatten([
    for user in sort(lookup(var.readwrite, "users")) : [
      for repo in sort(lookup(var.readwrite, "repos")) : {
        user = user
        repo = repo
      }
    ]
  ]))
}

module "admin_access" {
  source = ".//modules"

  organization_name = var.organization_name
  # enforce_rules     = var.enforce_rules
  team_repo = local.admin_team_repo_list

  repo_list = local.repo_list

  user_repo = local.admin_user_repo_list

  permission_rule = "admin"

  team_name = var.team_name
}

module "readonly_access" {
  source = ".//modules"

  organization_name = var.organization_name
  # enforce_rules     = var.enforce_rules
  team_repo = local.readonly_team_repo_list

  user_repo = local.readonly_user_repo_list

  permission_rule = "pull"

  team_name = var.team_name
}

module "readwrite_access" {
  source = ".//modules"

  organization_name = var.organization_name
  # enforce_rules     = var.enforce_rules
  team_repo = local.readwrite_team_repo_list

  user_repo = local.readwrite_user_repo_list

  permission_rule = "push"

  team_name = var.team_name
}



#######################
#       OUTPUTS       #
#######################

# output "org_data" {
#   value = module.readonly_access.org_data
# }

output "varibales_info" {
  value = module.admin_access.variable_info
}

# output "repo_list_info" {
#   value = module.admin_access.repo_list_info
# }


#######################
#       LOCALS        #
#######################

# admin_repo_list = sort(lookup(var.admin, "repos"))

# readonly_repo_list = sort(lookup(var.readonly, "repos"))

# readwrite_repo_list = sort(lookup(var.readwrite, "repos"))

# admin_user_list = sort(lookup(var.admin, "users"))

# readonly_user_list = sort(lookup(var.readonly, "users"))

# readwrite_user_list = sort(lookup(var.readwrite, "users"))
