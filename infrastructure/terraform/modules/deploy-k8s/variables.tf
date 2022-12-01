variable "location" {
  type    = string
  default = "westeurope"
}
variable "rg-name" {
  type    = string
  default = "dev-rg"
}
variable "role" {
  type = string
}
variable "prefix" {
  type = string

}
variable "agid" {
  type = string
}
variable "agname" {
  type = string
}
variable "tags" {
  type = map(string)
}