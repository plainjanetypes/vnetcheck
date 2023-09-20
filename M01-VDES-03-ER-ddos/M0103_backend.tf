#store state in terra general
backend "azurerm" {
    resource_group_name = ""
    storage_account_name = "terrageneral"
    container_name = "tfbackup"
    key = "M01-VDES-03-ER-ddos.tfstate"
}