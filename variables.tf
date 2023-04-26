variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "address_prefixes" {
  type = list(string)
}

variable "allocation_method" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "caching" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "source_image_publisher" {
  type = string
}

variable "source_image_offer" {
  type = string
}

variable "source_image_sku" {
  type = string
}

variable "source_image_version" {
  type = string
}
