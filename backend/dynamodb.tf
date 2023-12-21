resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table
  billing_mode = "PROVISIONED"
  write_capacity = 10
  read_capacity = 10
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}