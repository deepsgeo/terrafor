terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
 
}


# Create Network Security Group

resource "azurerm_network_security_group" "Demo" {
  name                = "publicNSG"
  location            = azurerm_resource_group.Demo.location
  resource_group_name = azurerm_resource_group.Demo.name
  tags = {
    environment = "test"
    client = "ABCCorp"
    costcenter = "abccorp"
  }
}

# Create Primary Resource Group 

resource "azurerm_resource_group"  "Demo" {
  name     = "TFDemo"
  location = "eastus"
  tags = {
    environment = "test"
    client = "ABCCorp"
    costcenter = "abccorp"
  }
}

# Create Second Resource Group

resource "azurerm_resource_group"  "Demo2" {
  name     = "TFDemo2"
  location = "westus"
}

# Create Virtual Network in 
resource "azurerm_virtual_network" "Demo" {
  name                = "TFVNet"
  location            = azurerm_resource_group.Demo.location
  resource_group_name = azurerm_resource_group.Demo.name
  address_space       = ["10.0.0.0/16"]
  
  subnet {
    name           = "public"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.Demo.id
  }


  tags = {
    environment = "test"
    client = "ABCCorp"
    costcenter = "abccorp"
  }
}