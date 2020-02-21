
resource "azurerm_policy_definition" "blee-policy-2" {
  name         = "blee-policy-2"
  display_name = "Policy-2"
  description  = "Policy-2-Description"
  policy_type  = "Custom"
  mode         = "All"
  policy_rule  = "${data.template_file.requiredTag_policy_rule.rendered}"
  parameters   = "${data.template_file.requiredTag_policy_parameters.rendered}"
}
