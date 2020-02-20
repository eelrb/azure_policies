# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.44.0"
}

data "template_file" "requiredTag_policy_rule" {
  template = <<POLICY_RULE
{
    "if": {
        "field": "[concat('tags[', parameters('tagName'), ']')]",
        "exists": "false"
    },
    "then": {
        "effect": "audit"
    }
}
POLICY_RULE
}

data "template_file" "requiredTag_policy_parameters" {
  template = <<PARAMETERS
{
    "tagName": {
        "type": "String",
        "metadata": {
            "displayName": "Tag Name",
            "description": "Name of the tag, such as 'environment'"
        }
    }
}
PARAMETERS
}

resource "azurerm_policy_definition" "blee-requiredTag" {
  name         = "Audit-RequiredTag-Resource"
  display_name = "Audit a Required Tag on a Resource"
  description  = "Audit all resources for a required tag"
  policy_type  = "Custom"
  mode         = "All"
  policy_rule  = "${data.template_file.requiredTag_policy_rule.rendered}"
  parameters   = "${data.template_file.requiredTag_policy_parameters.rendered}"
}
