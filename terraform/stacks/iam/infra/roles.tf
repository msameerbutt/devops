######################################################
# IAM Role for Portal Application EC2 Instance       #
######################################################
resource "aws_iam_role" "ec2_base" {
  name = format("%s-%s-%s-ec2_base", var.env_profile, var.env_name, var.stack_name)
  path = format("/%s/", var.env_profile)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = merge({ Name = format("%s-ec2_base", local.prefix_name_tag) }, local.default_tags)
}

# Create instance profile that will use the role created
resource "aws_iam_instance_profile" "ec2_base" {
  name = format("%s-%s-%s-ec2_base_profile", var.env_profile, var.env_name, var.stack_name)
  role = aws_iam_role.ec2_base.name
  depends_on = [
      aws_iam_role.ec2_base
  ]
}