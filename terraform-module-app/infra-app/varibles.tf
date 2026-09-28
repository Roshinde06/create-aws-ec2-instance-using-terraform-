variable "env" {
  description = "This a environment for my infra"
  type = string
}

variable "bucket_name" {
    description = "This is the bucket name for my infra"
    type = string
}
variable "instance_count" {
    description = "This the number of ec2 instance "
    type = number 
}

variable "instance_type" {
    description = "This is instace type of my ec2 "
    type = string
}

variable "instance_ami_id" {
  description = "This my ec2 ami id"
  type = string
}

variable "hash_key" {
 description = "This hash key for my dynombd table" 
 type = string
}