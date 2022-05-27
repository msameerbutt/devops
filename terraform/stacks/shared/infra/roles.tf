######################################################
# IAM Role for EC2 Web instance                      #
######################################################
resource "aws_iam_role" "ec2_web" {
  name = format("%s-%s-%s-ec2_web", var.env_profile, var.env_name, var.stack_name)
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
  tags = merge({ Name = format("%s-ec2_web", local.prefix_name_tag) }, local.default_tags)
}
resource "aws_iam_instance_profile" "ec2_web" {
  name = format("%s-%s-%s-ec2_web_profile", var.env_profile, var.env_name, var.stack_name)
  role = aws_iam_role.ec2_web.name
  depends_on = [
    aws_iam_role.ec2_web
  ]
}