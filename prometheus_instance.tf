
resource "aws_security_group" "prometheus_rules" {
  vpc_id      = data.aws_vpc.default.id
  name        = "prometheus-instance-rules"
  description = "security group that opens ssh and necessary ports for prometheus"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

}

data "aws_ami" "ubuntu_latest" {
  most_recent = true
  owners      = ["099720109477"] #Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "tls_private_key" "prometheus" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "prometheus" {
  key_name   = "prometheus"
  public_key = tls_private_key.prometheus.public_key_openssh
}

resource "aws_instance" "prometheus_instance" {

  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = tolist(data.aws_subnet_ids.default_vpc_subnets.ids)[0]
  vpc_security_group_ids      = [aws_security_group.prometheus_rules.id]
  key_name                    = aws_key_pair.prometheus.key_name

  tags = {
    Name        = "prometheus"
    Description = "ec2 instance for prometheus server"
  }

  volume_tags = {
    Name        = "prometheus"
    Description = "ec2 instance volume for prometheus server"
  }
}