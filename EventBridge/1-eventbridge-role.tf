# Create IAM Role for EventBridge
resource "aws_iam_role" "eventbridge_role" {
  name = var.iam_role_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "scheduler.amazonaws.com",
      },
    }],
  })
}

# Attach policies to the IAM Role
resource "aws_iam_role_policy_attachment" "eventbridge_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"  # Adjust based on your specific needs
  role       = aws_iam_role.eventbridge_role.name
}