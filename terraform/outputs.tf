output "bucket_name" {
  value = aws_s3_bucket.insurance_bucket.bucket
}

output "instance_public_ip" {
  value = aws_instance.insurance_ec2.public_ip
}
