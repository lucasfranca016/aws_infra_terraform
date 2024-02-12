# AWS S3 bucket resource for storing various objects
resource "aws_s3_bucket" "s3_bucket_raw" {
  for_each = var.bucket_names
  bucket   = "bixtech-${var.env}-${each.value}-${var.random_uuid}-tf" # Bucket name constructed using variables for environment and account ID
}
