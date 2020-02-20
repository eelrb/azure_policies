# Configure the Microsoft Azure Provider.
provider "azurerm" {
    version = "=1.30.0"
}

# Define Azure Policy Definition
resource "azurerm_policy_definition" "blee-policy" {
  name         = "PaC-Naming-Convention"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "PaC_Naming_Convention"

  metadata     = <<METADATA
    {
    "category": "Demo"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
    "if": {
		"allOf":[
			{
				"not":{
					"field":"name",
					"match":"[parameters('namePattern')]"
				}
			},
			{
				"field": "type",
				"equals": "Microsoft.Compute/virtualMachines"
			}
		]
    },
    "then": { 
      "effect": "deny"
    }
  }
POLICY_RULE

  parameters = <<PARAMETERS
    {
		"namePattern":{
			"type": "String",
			"metadata":{
				"displayName": "namePattern",
				"description": "? for letter, # for numbers"
			}
		}
  }
PARAMETERS
}
