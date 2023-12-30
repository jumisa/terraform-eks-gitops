variable "region" {
  default = "us-east-1"
  description = "AWS Region"
}
variable "cloudflare_api_token" {
  default = "AbcD1234efGH5678AbcD1234efGH567812345678"
  description = "API Token from CLoudflare Domain"
}
variable "r53record" {
  description = "Base and Sub domain for the Public hosted zone are defined"
}
variable "name" {
  description = "Name prefix for the resources"
}
variable "vpc" {
  description = "Necessary Variables, Values for the VPC Resource"
}
variable "tags" {
  description = "Set of key / value pairs for AWS tags to be applied all resources"
}