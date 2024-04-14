resource "aws_ecr_repository" "ecr_repository" {
  name                  = var.ecr_repo_name
  image_tag_mutability  = var.image_tag_mutability
  #force_delete          = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = var.ecr_repo_name
    Project = "${var.project_name}-${var.project_suffix}"
  }
}