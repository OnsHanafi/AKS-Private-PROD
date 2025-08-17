# NEEDS OTHER CONFIG SINCE WE CHANGED FOR BASTION
# -------------------------
# NSG JUMBOX
# -------------------------
# resource "azurerm_network_security_group" "jumpbox_nsg" {
#   name                = "jumpbox-nsg"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name

#   security_rule {
#     name                       = "SSH"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "jumpbox_assoc" {
#   subnet_id                 = azurerm_subnet.vm_subnet.id
#   network_security_group_id = azurerm_network_security_group.jumpbox_nsg.id
# }

# PUBLIC IP
# resource "azurerm_public_ip" "jumpbox_ip" {
#   name                = "jumpbox-pip"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# -------------------------
# JUMPBOX VM
# -------------------------

resource "azurerm_network_interface" "jumpbox_nic" {
  name                = "jumpbox-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.jumpbox_subnet.id
    private_ip_address_allocation = "Dynamic"
    #  CONNECTING THROUGH BASTION
    # public_ip_address_id           = azurerm_public_ip.jumpbox_ip.id
    public_ip_address_id = null
  }
}

resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                = "jumpbox"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = var.jumpbox_size
  admin_username      = "azureuser"

  network_interface_ids = [azurerm_network_interface.jumpbox_nic.id]

  priority = "Spot"
  eviction_policy = "Delete"

  # INSTALL NEEDED TOOLS
  custom_data = filebase64("./000-tools.sh")

  # SP CREATED
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.identity-vm.id]
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-25_04" #OR "0001-com-ubuntu-server-jammy" 
    sku       = "22_04-lts-gen2"  #OR "minimal"
    version   = "latest"
  }

  #IF NEEDED
  # os_disk {
  #   name                 = "os-disk-vm"
  #   caching              = "ReadOnly"        # "ReadWrite" # None, ReadOnly and ReadWrite.
  #   storage_account_type = "StandardSSD_LRS" # "Standard_LRS"
  #   disk_size_gb         = 128

  #   diff_disk_settings {
  #     option    = "Local"    # Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local.
  #     placement = "NvmeDisk" # "ResourceDisk" # "CacheDisk" # Specifies the Ephemeral Disk Placement for the OS Disk. NvmeDisk can only be used for v6 VMs
  #   }
  # }

}


