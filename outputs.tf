output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.tests-vm.name}: ${data.azurerm_public_ip.tests-public-ip-data.ip_address}"
}