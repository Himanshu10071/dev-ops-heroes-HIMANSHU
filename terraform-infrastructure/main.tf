resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name
  tags = {
    Environment = "Dev"
    Project     = "Terraform S3 Demo"
  }
}
