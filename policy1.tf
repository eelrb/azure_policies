data "template_file" "requiredTag_policy_rule_1" {
  template = <<POLICY_RULE
{
    "if": {
        "field": "[concat('tags[', parameters('tagName'), ']')]",
        "exists": "true"
    },
    "then": {
        "effect": "disabled"
    }
}
POLICY_RULE
}

data "template_file" "requiredTag_policy_parameters_1" {
  template = <<PARAMETERS
{
    "tagName": {
        "type": "String",
        "metadata": {
            "displayName": "Tag Name",
            "description": "Name of tag, such as 'environment'"
        }
    }
}
PARAMETERS
}

resource "azurerm_policy_definition" "blee-policy-1" {
  name         = "blee-policy-1"
  display_name = "Audit a Required Tag on a Resource"
  description  = "Audit all resources for a required tag"
  policy_type  = "Custom"
  mode         = "All"
  policy_rule  = "${data.template_file.requiredTag_policy_rule_1.rendered}"
  parameters   = "${data.template_file.requiredTag_policy_parameters_1.rendered}"
}
