######################################################
# IAM Role for EC2 Web instance                      #
######################################################
resource "aws_iam_role" "webserver" {
  name = format("%s-webserver-role", local.prefix_name_tag)
  path = format("/%s/", var.environment)
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
  tags = merge({
     Name = format("%s-webserver-role", local.prefix_name_tag)
     resource_type = "aws_iam_role"
     resource_name =  "webserver"
    }, local.default_tags
  )
}
resource "aws_iam_instance_profile" "webserver" {
  name = format("%s-webserver-role", local.prefix_name_tag)
  role = aws_iam_role.ec2_web.name
  depends_on = [
    aws_iam_role.ec2-web
  ]
  tags = merge({
     Name = format("%s-webserver-iprofile", local.prefix_name_tag)
     resource_type = "aws_iam_instance_profile"
     resource_name =  "webserver"
    }, local.default_tags
  )  
}
