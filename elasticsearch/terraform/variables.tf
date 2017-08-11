## AWS Gobal settings

variable "ssh_key_name" {
  description = "Name of AWS key pair"
}

variable "aws_access_key" {
  description = "The access key for the terraform user"
}

variable "aws_secret_key" {
  description = "The secret key for the terraform user"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "AWS region to launch servers."
  default     = "us-east-1a,us-east-1b,us-east-1c,us-east-1d,us-east-1e"
}

variable "aws_vpc_id" {
  description = "These templates assume a VPC already exists"
}

# Autoscaling Group Settings

# r3.xlarge is a good economic default for full planet builds
# for more performance, use c4.4xlarge or similar. High throughput
# geocoders really love having lots of CPU available
variable "elasticsearch_instance_type" {
  description = "Elasticsearch instance type."
  default = "r3.xlarge"
}

# Elasticsearch ASG instance counts
# a minimum of 5 r3.xlarge instances is needed for a full planet build
variable "elasticsearch_min_instances" {
  description = "total instances"
  default = "5"
}

variable "elasticsearch_desired_instances" {
  description = "total instances"
  default = "5"
}
variable "elasticsearch_max_instances" {
  description = "total instances"
  default = "5"
}

## Launch Configuration settings

variable "elasticsearch_root_volume_size" {
  default = "8"
}

variable "elasticsearch_data_volume_size" {
  default = "200"
}

variable "elasticsearch_log_volume_size" {
  default = "5"
}

variable "elasticsearch_data_volume_name" {
  default = "/dev/xvdb"
}

variable "elasticsearch_log_volume_name" {
  default = "/dev/xvdc"
}

variable "elasticsearch_data_dir" {
  default = "/usr/local/var/data/elasticsearch"
}

variable "elasticsearch_log_dir" {
  default = "/usr/local/var/log/elasticsearch"
}

# General settings
variable "service_name" {
  description = "Used as a prefix for all instances in case you are running several distinct services"
  default = "pelias"
}

variable "environment" {
  description = "Which environment (dev, staging, prod, etc) this group of machines is for"
  default = "dev"
}