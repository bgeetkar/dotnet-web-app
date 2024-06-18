# create a service role for codedeploy
resource "aws_iam_role" "ticket99_codedeploy_service" {
  name = "${var.APP_NAME}_${var.ENVIRONMENT}_codedeploy_service_role" # Replacing '-' with '_' to adhere to naming restrictions
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# attach AWS managed policy called AWSCodeDeployRole
# required for deployments which are to an EC2 compute platform
resource "aws_iam_role_policy_attachment" "codedeploy_service" {
  role       = aws_iam_role.ticket99_codedeploy_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}


 # create a service role for ec2
 resource "aws_iam_role" "web_server_iam_role" {
   name = "${var.APP_NAME}_${var.ENVIRONMENT}_web_iam_role"

   assume_role_policy = <<EOF
 {
   "Version": "2012-10-17",
   "Statement": [
     {
       "Sid": "",
       "Effect": "Allow",
       "Principal": {
         "Service": [
           "ec2.amazonaws.com"
         ]
       },
       "Action": "sts:AssumeRole"
     }
   ]
 }
 EOF
 }

data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = [
      "ec2:Describe*"
      ]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:ListBucket",
        "s3:GetObjectTagging"
      ]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = [
        "s3:put*"
      ]
    resources = [
      "arn:aws:s3:::ticket99-artifacts-bucket",
      "arn:aws:s3:::ticket99-artifacts-bucket/*"
      ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.APP_NAME}_${var.ENVIRONMENT}_web_iam_role_policy"
  description = "${var.APP_NAME}_${var.ENVIRONMENT}_web_iam_role_policy"
  policy      = data.aws_iam_policy_document.policy.json
}

 # provide ec2 access to s3 bucket to download revision. This role is needed by the CodeDeploy agent on EC2 instances.
 resource "aws_iam_role_policy_attachment" "instance_profile_codedeploy" {
   role       = "${aws_iam_role.web_server_iam_role.name}"
   policy_arn = aws_iam_policy.policy.arn
 }

 resource "aws_iam_instance_profile" "ticket99_iam_instance_profile" {
   name = "${var.APP_NAME}_${var.ENVIRONMENT}_web_iam_instance_profile"
   role = "${aws_iam_role.web_server_iam_role.name}"
 }