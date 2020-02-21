
resource "azurerm_policy_definition" "blee-policy-2" {
  name         = "blee-policy-2"
  display_name = "Audit a Required Tag on a Resource"
  description  = "Audit all resources for a required tag"
  policy_type  = "Custom"
  mode         = "All"
  policy_rule  = "${data.template_file.requiredTag_policy_rule.rendered}"
  parameters   = "${data.template_file.requiredTag_policy_parameters.rendered}"
}
