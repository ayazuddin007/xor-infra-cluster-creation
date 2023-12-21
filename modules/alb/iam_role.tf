#ROLE
resource "aws_iam_role" "alb_role" {
  name = "${var.ClusterName}-alb-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${local.ACCOUNT_ID}:oidc-provider/${var.OIDC_PROVIDER}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.OIDC_PROVIDER}:sub" : "system:serviceaccount:${var.namespace}:${var.service_account_name}"
          }
        }
      }
    ]
  })

  tags = {
    Name = "${var.ClusterName}-alb-role"
  }

  lifecycle {
    ignore_changes = [
      assume_role_policy
    ]
  }

  
}

#POLICY
resource "aws_iam_policy" "policy" {
  name   = "AWSLoadBalancerControllerIAMPolicy-${var.ClusterName}"
  policy = file("../modules/alb/policy.json")


}


#ATTACHING POLICY TO ROLE
resource "aws_iam_role_policy_attachment" "alb_policy" {
  role       = aws_iam_role.alb_role.name
  policy_arn = aws_iam_policy.policy.arn

}
