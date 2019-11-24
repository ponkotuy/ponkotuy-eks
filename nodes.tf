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
  instance_type = "t3.micro"
}

data "aws_ssm_parameter" "eks-image-id" {
  name = "/aws/service/eks/optimized-ami/${var.eks_version}/amazon-linux-2/recommended/image_id"
}
