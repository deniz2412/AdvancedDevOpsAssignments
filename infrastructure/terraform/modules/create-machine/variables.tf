variable "location" {
    type = string
}
variable "rg-name" {
    type = string
}
variable "NSG-ID" {
    type = string
}

variable "storage-type" {
    default = "Premium_LRS"  
}
variable "prefix" {
  type = string
}
variable "vm-name" {
  type = string
}
variable "subnet-id" {
  type = string
}
variable "domain_name_label" {
  type = string
  default = null
}
variable "tags" {
  type = map(string)  
}
variable "size" {
  type = string
  default ="Standard_B2s"  
}