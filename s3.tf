# AWS S3 bucket resource for storing various objects
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "bixtech-${var.env}-${var.random_uuid}-tf" # Bucket name constructed using variables for environment and account ID
}

# AWS S3 folder for landing zone
resource "aws_s3_object" "landing" {
  bucket = aws_s3_bucket.s3_bucket.id # Reference to the previously created S3 bucket
  key    = "landing/"                 # Key for the landing zone folder
}

# AWS S3 folder for raw data storage
resource "aws_s3_object" "raw" {
  bucket = aws_s3_bucket.s3_bucket.id # Reference to the previously created S3 bucket
  key    = "raw/"                     # Key for the raw folder objects
}

# AWS S3 folder for trusted data storage
resource "aws_s3_object" "trusted" {
  bucket = aws_s3_bucket.s3_bucket.id # Reference to the previously created S3 bucket
  key    = "trusted/"                 # Key for the trusted folder objects
}

# AWS S3 folder for refined data storage
resource "aws_s3_object" "refined" {
  bucket = aws_s3_bucket.s3_bucket.id # Reference to the previously created S3 bucket
  key    = "refined/"                 # Key for the refined folder objects
}
