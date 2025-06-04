resource "aws_s3_bucket" "insurance_bucket" {
  bucket = "auto-insurance-portal-files-${random_id.bucket_suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "InsuranceFileStorage"
    Environment = "Dev"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_iam_role" "ec2_role" {
  name = "insurance-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Effect = "Allow",
      Sid = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_instance" "insurance_ec2" {
  ami                    = var.app_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  iam_instance_profile   = aws_iam_instance_profile.insurance_profile.name

  tags = {
    Name = "InsuranceAppInstance"
  }
}

resource "aws_iam_instance_profile" "insurance_profile" {
  name = "insurance-instance-profile"
  role = aws_iam_role.ec2_role.name
}
