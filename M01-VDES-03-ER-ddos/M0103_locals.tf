data "azurerm_storage_account" "diagstorage" {
    name = "terrageneral"
    resource_group_name = "generalrg"
}
data "azurerm_key_vault" "genkv" {
    name = "generalkv"
    resource_group_name = "generalrg"
}
data "azurerm_key_vault_secret" "genkvsecrets" {
    name = ""
}
locals {
  dnsvms = split("\n",(file("M0103_dnsvmsnames.txt")))
}