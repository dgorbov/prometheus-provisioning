variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_profile" {
  default = "default"
}

variable "allowed_cidr" {
  type = list(string)
  default = ["109.106.142.117/32", "82.151.125.64/32"]
}