locals {
  aws_k8s_role_mapping = [{
      rolearn = aws_iam_role.external-admin.arn
      username = "admin"
      groups = ["none"]
    },
    {
      rolearn = aws_iam_role.external-developer.arn
      username = "developer"
      groups = ["none"]
    }
  ]
}

resource "aws_iam_role" "external-admin" {
  name = "external-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = var.user_for_admin_role
        }
      }
    ]
  })

  inline_policy {
    name = "external-admin-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {       
          Action   = ["eks:DescribeCluster"]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_iam_role" "external-developer" {
  name = "external-developer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = var.user_for_dev_role
        }
      }
    ]
  })

  inline_policy {
    name = "external-developer-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["eks:DescribeCluster"]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}