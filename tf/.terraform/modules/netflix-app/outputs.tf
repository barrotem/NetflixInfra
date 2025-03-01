#Define module outputs
output "instance_id" {
  description = "The ID of the netflix instance"
  value       = aws_instance.netflix_app.id
}

output "bucket_name" {
  description = "The name of the netflix bucket"
  value       = aws_s3_bucket.netflix_bucket.bucket
}