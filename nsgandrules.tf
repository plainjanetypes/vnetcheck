# create an nsg and add rules

resource "azurerm_network_security_group" "genericnsg" {
            name = "nsgall"
            location = "centralus"

}