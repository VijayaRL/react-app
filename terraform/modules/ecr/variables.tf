# Tag Mutability 
variable "image_tag_mutability" {
  type        = string
  description = "Image tag mutability"
  default     = "MUTABLE"
}

# AWS Project Name
variable "project_name" {
  type        = string
  description = "AWS Project Name"
}

# AWS Project Suffix
variable "project_suffix" {
  type        = string
  description = "AWS Project Suffix"
}

# ECR Repository Name
variable "ecr_repo_name" {
  type        = string
  description = "ECR Repository Name"
}