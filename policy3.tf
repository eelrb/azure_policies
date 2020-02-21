
resource "azurerm_policy_definition" "blee-policy-3" {
  name         = "blee-policy-3"
  display_name = "Policy-3"
  description  = "Policy-3-Description"
  policy_type  = "Custom"
  mode         = "All"
  policy_rule  = "${data.template_file.requiredTag_policy_rule.rendered}"
  parameters   = "${data.template_file.requiredTag_policy_parameters.rendered}"
}
