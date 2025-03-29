# Input Variables

# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-west-1"
}

# Environment Variables
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "int"
}

# Business Division
variable "business_division" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "BDH"
}
