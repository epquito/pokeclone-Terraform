data "aws_iam_policy_document" "pokemon_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:pokemon-test"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "pokemon_oidc" {
  assume_role_policy = data.aws_iam_policy_document.pokemon_oidc_assume_role_policy.json
  name               = "pokemon-oidc"
}

resource "aws_iam_policy" "pokemon-policy" {
  name = "pokemon-policy"

  policy = jsonencode({
    Statement = [{
      Action   = ["s3:ListAllMyBuckets", "s3:GetBucketLocation"]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "pokemon_attach" {
  role       = aws_iam_role.pokemon_oidc.name
  policy_arn = aws_iam_policy.pokemon-policy.arn
}

output "pokemon_policy_arn" {
  value = aws_iam_role.pokemon_oidc.arn
}
# Data block for TLS Certificate
data "tls_certificate" "eks" {
  url = aws_eks_cluster.pokemon-cluster.identity[0].oidc[0].issuer
}

# IAM OpenID Connect Provider
resource "aws_iam_openid_connect_provider" "eks" {
  # Update with the correct client ID(s) for your OIDC provider
  client_id_list  = ["sts.amazonaws.com"]

  # Update with the correct TLS certificate thumbprint for your OIDC provider
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]

  # Update with the correct OIDC issuer URL for your EKS cluster
  url             = aws_eks_cluster.pokemon-cluster.identity[0].oidc[0].issuer
}
