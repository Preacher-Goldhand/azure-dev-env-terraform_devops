terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.53.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "tests-rg" {
  name     = "terraform-tests-rg"
  location = var.location

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_virtual_network" "tests-vn" {
  name                = "terraform-tests-network"
  location            = azurerm_resource_group.tests-rg.location
  resource_group_name = azurerm_resource_group.tests-rg.name
  address_space       = var.address_space

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_subnet" "tests-subnet" {
  name                 = "terraform-test-subnet-1"
  resource_group_name  = azurerm_resource_group.tests-rg.name
  virtual_network_name = azurerm_virtual_network.tests-vn.name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_network_security_group" "tests-sg" {
  name                = "terraform-tests-sg"
  location            = azurerm_resource_group.tests-rg.location
  resource_group_name = azurerm_resource_group.tests-rg.name

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_network_security_rule" "tests-dev-rule" {
  name                        = "terraform-tests-dev-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tests-rg.name
  network_security_group_name = azurerm_network_security_group.tests-sg.name
}

resource "azurerm_subnet_network_security_group_association" "tests-sga" {
  subnet_id                 = azurerm_subnet.tests-subnet.id
  network_security_group_id = azurerm_network_security_group.tests-sg.id
}

resource "azurerm_public_ip" "test-public-ip" {
  name                = "terraform-tests-public-ip-1"
  resource_group_name = azurerm_resource_group.tests-rg.name
  location            = azurerm_resource_group.tests-rg.location
  allocation_method   = var.allocation_method

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_network_interface" "tests-nic" {
  name                = "terraform-tests-nic"
  location            = azurerm_resource_group.tests-rg.location
  resource_group_name = azurerm_resource_group.tests-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tests-subnet.id
    private_ip_address_allocation = var.allocation_method
    public_ip_address_id          = azurerm_public_ip.test-public-ip.id
  }

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_linux_virtual_machine" "tests-vm" {
  name                = "terraform-tests-dev-vm"
  resource_group_name = azurerm_resource_group.tests-rg.name
  location            = azurerm_resource_group.tests-rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.tests-nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${var.public_key_path}")
  }

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  tags = {
    environment = "Dev"
  }
}

data "azurerm_public_ip" "tests-public-ip-data" {
  name                = azurerm_public_ip.test-public-ip.name
  resource_group_name = azurerm_resource_group.tests-rg.name
}
