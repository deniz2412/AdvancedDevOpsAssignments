
variable "location" {
    type = string
}
variable "rg-name" {
    type = string
}
variable "prefix" {
  type = string
}
variable "tags" {
  type = map(string)
  
}
variable "aks_fqdn" {
  type = string
}