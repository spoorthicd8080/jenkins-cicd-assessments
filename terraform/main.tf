data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "project_artifacts" {
  bucket = "${var.project_name}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${var.project_name}-artifacts"
    Environment = "dev"
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "project_artifacts" {
  bucket = aws_s3_bucket.project_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}