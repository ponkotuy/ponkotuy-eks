resource "aws_eks_cluster" "ponkotuy-eks" {
  name = var.cluster_name
  role_arn = aws_iam_role.eks-master.arn
  version = var.eks_version
  vpc_config {
    subnet_ids = [
      data.aws_subnet.az-a.id,
      data.aws_subnet.az-c.id,
      data.aws_subnet.az-d.id
    ]
  }
}
