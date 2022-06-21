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

variable "ssl_cert" {
  description = "Name and domains of the SSL Certificate"
  type        = map(list(string))
}

#######################
####   URL Maps   ####
#######################

variable "bucket_backend" {
  description = "The self_link of the empty bucket"
  type        = string
}

variable "hostnames" {
  type = list(string)
}

######################################
####  Backend Ser. and Healtcheck ####
######################################

variable "backends" {
  description = "The Backend Service which handles the request. 'backend name = {healthy_threshold = 'xxx', port = 'xxx', unhealthy_threshold = 'xxx'}'"
  type = map(object({
    port_name   = string
    timeout_sec = number

    health_check = object({
      check_interval_sec  = number
      timeout_sec         = number
      healthy_threshold   = number
      unhealthy_threshold = number
      port                = number
    })

    groups = list(object({
      group = string

    }))

  }))

}
