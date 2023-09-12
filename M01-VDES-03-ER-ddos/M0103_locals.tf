data "azurerm_storage_account" "diagstorage" {
    name = "terrageneral"
    resource_group_name = "generalrg"
}

locals {
  dnsvms = split("\n",(file("M0103_dnsvmsnames.txt")))
}