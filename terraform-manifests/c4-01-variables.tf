# VPC input variables

# VPC name
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default = "myvpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "The CIDR Block of the VPC"
  type        = string
  default = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  description = "The availability zones of the VPC"
  type        = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "The public subnets of the VPC"
  type        = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "The private subnets of the VPC"
  type        = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# VPC Database Subnets
variable "vpc_database_subnets" {
  description = "The database subnets of the VPC"
  type        = list(string)
  default = ["10.0.151.0/24", "10.0.152.0/24"]
}

# Create VPC database subnet group
variable "vpc_create_database_subnet_group" {
  description = "Create database subnet group"
  type        = bool
  default     = false
}

# VPC create database subnet route table
variable "vpc_create_database_subnet_route_table" {
  description = "Create database subnet route table"
  type        = bool
  default     = false
}

# VPC Enable NAT Gateway
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}

# VPC Signle NAT Gateway    
variable "vpc_single_nat_gateway" {
  description = "Single NAT Gateway"
  type        = bool
  default     = true
}