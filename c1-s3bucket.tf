module "website_s3_bucket" {
  source = "/root/aws_s3_static_website_using_terraform/modules/aws-s3-static-website-bucket"
  bucket_name = var.my_s3_bucket
  tags = var.my_s3_tags
}
