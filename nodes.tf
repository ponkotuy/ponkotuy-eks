resource "aws_autoscaling_group" "ponkotuy-eks" {
  name = var.project_name
  max_size = 2
  min_size = 1
  vpc_zone_identifier = [data.aws_subnet.az-a.id]

  launch_configuration = aws_launch_configuration.ponkotuy-eks-launch.id

  tag {
    key = "Name"
    value = "${var.project_name}-nodes"
    propagate_at_launch = true
  }

  tag {
    key = "kubernetes.io/cluster/${aws_eks_cluster.ponkotuy-eks.name}"
    value = "owned"
    propagate_at_launch = true
  }

  tag {
    key = "k8s.io/cluster-autoscaler/ponkotuy"
    value = "owned"
    propagate_at_launch = true
  }

  tag {
    key = "eks:cluster-name"
    propagate_at_launch = true
    value = "ponkotuy"
  }

  tag {
    key = "eks:nodegroup-name"
    value = "default"
    propagate_at_launch = true
  }

  tag {
    key = "k8s.io/cluster-autoscaler/enabled"
    value = "true"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "ponkotuy-eks-launch" {
  name_prefix = "ponkotuy-eks"
  image_id = data.aws_ssm_parameter.eks-image-id.value
  instance_type = var.instance_size

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_ssm_parameter" "eks-image-id" {
  name = "/aws/service/eks/optimized-ami/${var.eks_version}/amazon-linux-2/recommended/image_id"
}

resource "aws_eks_node_group" "ponkotuy-default" {
  cluster_name = aws_eks_cluster.ponkotuy-eks.name
  node_group_name = "default"
  node_role_arn = aws_iam_role.eks-node-role.arn
  subnet_ids = [data.aws_subnet.az-a.id]
  instance_types = [var.instance_size]
  disk_size = var.instance_disk_size

  scaling_config {
    desired_size = 1
    max_size = 2
    min_size = 1
  }
}
