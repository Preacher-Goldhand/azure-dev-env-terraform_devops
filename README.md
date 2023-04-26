Terraform Azure Dev Environment 

This Terraform configuration file deploys a Linux virtual machine with a public IP address, a virtual network, and a network security group in Azure.

Resources Created:
   - azurerm_resource_group: resource group to contain all resources
   - azurerm_virtual_network: virtual network for the VM
   - azurerm_subnet: subnet for the VM
   - azurerm_network_security_group: network security group for the VM
   - azurerm_network_security_rule: inbound security rule for SSH access
   - azurerm_subnet_network_security_group_association: associates the subnet with the network security group
   - azurerm_public_ip: public IP address for the VM
   - azurerm_network_interface: network interface for the VM
   - azurerm_linux_virtual_machine: Linux virtual machine with SSH access