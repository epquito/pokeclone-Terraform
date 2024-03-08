/*
# Create a Route 53 hosted zone
resource "aws_route53_zone" "pokeclone_zone" {
  name = "pokeclone-eks.com"
}

resource "aws_route53_record" "eks_cname_record" {
  zone_id = aws_route53_zone.pokeclone_zone.zone_id
  name    = pokeclone-eks.com
  type    = "CNAME"
  ttl     = 300

  records = [
    aws_eks_cluster.pokemon-cluster.endpoint
  ]
}

*/