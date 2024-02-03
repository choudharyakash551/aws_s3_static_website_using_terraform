resource "aws_s3_bucket" "s3web" {
  bucket = var.bucket_name
  tags = var.tags
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "s3web" {
  bucket = aws_s3_bucket.s3web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_versioning" "s3web" {
  bucket = aws_s3_bucket.s3web.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3web" {
  bucket = aws_s3_bucket.s3web.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3web" {
  bucket = aws_s3_bucket.s3web.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3web" {
  depends_on = [ aws_s3_bucket_ownership_controls.s3web,
  aws_s3_bucket_public_access_block.s3web ]
  bucket = aws_s3_bucket.s3web.id
  acl = "public-read"
}

resource "aws_s3_bucket_policy" "s3web" {
  bucket = aws_s3_bucket.s3web.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.bucket_name}/*"
          ]
      }
  ]
}  
EOF
}
