#######################
###  Resource Wide  ###
#######################

variable "project" {
  description = "Project ID"
  type        = string
}

variable "name" {
  description = "This will be the name of the application (cosmos|cosmosnet|interop|creport), which will be used in several names across resources"
  type        = string
}

variable "env" {
  description = "The environment all the resources belong."
  type        = string
}

#######################
####   SSL Certs   ####
#######################

variable "managed_domains" {
  description = "Domains for which a managed SSL certificate will be valid"
  type        = list(any)
}

#######################
####   URL Maps   ####
#######################

variable "bucket_backend" {
  description = "The self_link of the empty bucket"
  type        = string
}

variable "hostnames" {
  type                 = list(string)
  default              = null
}

variable "backend_bucket" {
  description = "The self_link of the backend service"
  type        = string
}

#######################
####   URL Maps   ####
#######################