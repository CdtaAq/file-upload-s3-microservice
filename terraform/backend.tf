terraform {
  backend "s3" {
    bucket = "your-tfstate-bucket"
    key    = "auto-insurance/terraform.tfstate"
    region = "us-east-1"
  }
}
