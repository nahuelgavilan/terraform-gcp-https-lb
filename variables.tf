#######################
###  Resource Wide  ###
#######################

variable "project" {
  description = "Project ID"
  type        = string
  default     = "gbc-cosmos-pre"
}

variable "env" {
  description = "The environment all the resources belong."
  type        = string
  default     = "pre"
}

#######################
####   SSL Certs   ####
#######################

variable "zone" {
  default = "europe-west1-b"

}

variable "region" {
  default = "europe-west1"
  
}