# The following block of locals are used to avoid using
# empty object types in the code
locals {
  empty_list   = []
  empty_map    = {}
  empty_string = ""
}

# The following locals are used to convert basic input
# variables to locals before use elsewhere in the module
locals {
  root_id                    = var.root_id
  root_name                  = var.root_name
  root_parent_id             = var.root_parent_id
  deploy_core_landing_zones  = var.deploy_core_landing_zones
  archetype_config_overrides = var.archetype_config_overrides
  subscription_id_overrides  = var.subscription_id_overrides
  deploy_demo_landing_zones  = var.deploy_demo_landing_zones
  custom_landing_zones       = var.custom_landing_zones
  library_path               = var.library_path
  template_file_variables    = var.template_file_variables
  default_location           = var.default_location
}

# The following locals are used to define base Azure
# provider paths and resource types
locals {
  provider_path = {
    management_groups = "/providers/Microsoft.Management/managementGroups/"
    role_assignment   = "/providers/Microsoft.Authorization/roleAssignments/"
  }
  resource_types = {
    policy_definition     = "Microsoft.Authorization/policyDefinitions"
    policy_set_definition = "Microsoft.Authorization/policySetDefinitions"
  }
}

# The following locals are used to define RegEx
# patterns used within this module

locals {
  regex_extract_provider_scope = "(?i)/(?=.*/providers/)[^/]+/[\\S]+(?=.*/providers/)"
}

# The following locals are used to control time_sleep
# delays between resources to reduce transient errors
# relating to replication delays in Azure

locals {
  default_create_duration_delay  = "30s"
  default_destroy_duration_delay = "0s"
  create_duration_delay = {
    after_azurerm_management_group      = try(var.create_duration_delay["azurerm_management_group"], local.default_create_duration_delay)
    after_azurerm_policy_assignment     = try(var.create_duration_delay["azurerm_policy_assignment"], local.default_create_duration_delay)
    after_azurerm_policy_definition     = try(var.create_duration_delay["azurerm_policy_definition"], local.default_create_duration_delay)
    after_azurerm_policy_set_definition = try(var.create_duration_delay["azurerm_policy_set_definition"], local.default_create_duration_delay)
    after_azurerm_role_assignment       = try(var.create_duration_delay["azurerm_role_assignment"], local.default_create_duration_delay)
    after_azurerm_role_definition       = try(var.create_duration_delay["azurerm_role_definition"], local.default_create_duration_delay)
  }
  destroy_duration_delay = {
    after_azurerm_management_group      = try(var.destroy_duration_delay["azurerm_management_group"], local.default_destroy_duration_delay)
    after_azurerm_policy_assignment     = try(var.destroy_duration_delay["azurerm_policy_assignment"], local.default_destroy_duration_delay)
    after_azurerm_policy_definition     = try(var.destroy_duration_delay["azurerm_policy_definition"], local.default_destroy_duration_delay)
    after_azurerm_policy_set_definition = try(var.destroy_duration_delay["azurerm_policy_set_definition"], local.default_destroy_duration_delay)
    after_azurerm_role_assignment       = try(var.destroy_duration_delay["azurerm_role_assignment"], local.default_destroy_duration_delay)
    after_azurerm_role_definition       = try(var.destroy_duration_delay["azurerm_role_definition"], local.default_destroy_duration_delay)
  }
}
