variable "named_port" {
  type = map(number)
}

variable "health_check" {
  type = map(object({
    check_interval_sec  = number
    timeout_sec         = number
    healthy_threshold   = number
    unhealthy_threshold = number
    port                = number
    })
  )

}

variable "zone" {
  type = string
}

variable "region" {
  type = string 
}

variable "env" {
    type = string
}

variable "project" {
    type = string
  
}

variable "name" {
  type = string
}