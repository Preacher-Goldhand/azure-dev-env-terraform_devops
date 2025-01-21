# Terraform Azure Dev Environment

This Terraform configuration deploys a complete development environment in Microsoft Azure. It provisions a Linux Virtual Machine (VM) with a public IP address, alongside the necessary networking components to ensure secure and efficient connectivity.

## Resources Created

### Resource Group
- **`azurerm_resource_group`**: Contains all resources to keep them organized within Azure.

### Networking Components
1. **`azurerm_virtual_network`**: Defines the virtual network for the environment.
2. **`azurerm_subnet`**: Allocates a subnet within the virtual network for the VM.
3. **`azurerm_network_security_group`**: Controls inbound and outbound traffic for the VM.
4. **`azurerm_network_security_rule`**: Allows inbound SSH access (port 22) for secure remote management.
5. **`azurerm_subnet_network_security_group_association`**: Links the subnet with the network security group for enhanced security.

### Public Connectivity
- **`azurerm_public_ip`**: Assigns a public IP address to the VM for external access.

### Virtual Machine Components
1. **`azurerm_network_interface`**: Connects the VM to the virtual network and public IP.
2. **`azurerm_linux_virtual_machine`**: Creates a Linux-based virtual machine with SSH access enabled.

## Prerequisites

- **Terraform**: Ensure you have Terraform installed on your local machine. You can download it from [Terraform's official website](https://www.terraform.io/downloads).
- **Azure Subscription**: A valid Azure account is required to deploy the resources.
- **SSH Key Pair**: An SSH public/private key pair for VM access.

## Usage

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Plan the deployment**:
   ```bash
   terraform plan
   ```

4. **Apply the configuration**:
   ```bash
   terraform apply
   ```

   Confirm the operation when prompted. Terraform will provision the resources in your Azure account.

5. **Access the VM**:
   Retrieve the public IP address of the VM and connect using SSH:
   ```bash
   ssh -i <path-to-private-key> azureuser@<public-ip>
   ```

## Cleanup

To destroy the resources and avoid incurring additional costs, run:
```bash
terraform destroy
```

## Architecture Diagram

Below is a simplified representation of the deployed architecture:

```
+-----------------------+
|     Resource Group    |
+-----------------------+
           |
           v
+-----------------------+
|    Virtual Network    |
+-----------------------+
           |
           v
+-----------------------+
|         Subnet         |
+-----------------------+
           |
           v
+-----------------------+     +-----------------------+
|  Network Security     |     |    Public IP Address   |
|       Group           |     +-----------------------+
+-----------------------+                |
           |                              v
           +------------------> Network Interface
                                     |
                                     v
                           +-----------------------+
                           |  Linux Virtual Machine |
                           +-----------------------+
```

## Notes

- **Security**: The configuration uses an inbound security rule to allow SSH access. Ensure that your SSH key pair is secure and rotate it periodically.
- **Customizations**: Adjust variables and resource configurations as needed to fit your specific requirements.
