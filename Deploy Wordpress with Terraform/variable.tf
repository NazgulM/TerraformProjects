variable "region" {
    type        =  string
    description =  "aws region"
}

variable "instance_type" {
    type        = string
    description = "instance type for wordpress"
}

variable "instance_count" {
    type        = number
    description = "number of instance to deploy"
}

variable "image_id" {
    type        = string
    description = "launch template image id"
}

variable "desired_capacity" {
    type        = number
    description = "desired instance"
}

variable "max_size" {
    type        = number
    description = "maximum amount of instance running"
}

variable "min_size" {
  type        = number
  description = "minimum amount of instance running"
}