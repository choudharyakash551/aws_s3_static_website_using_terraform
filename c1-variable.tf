variable "my_s3_bucket" {
  description = "bucket name"
  type = string
}

variable "my_s3_tags" {
  description = "given tag to the bucket"
  type = map(string)
}
