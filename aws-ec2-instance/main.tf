// ------------------
//  EC2 Instance
// ------------------

resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = var.associate_public_ip_address

  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.data_volume_size
    volume_type           = var.data_volume_type
    delete_on_termination = var.data_volume_delete_on_termination
    encrypted             = var.data_volume_encrypted
  }

  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "this" {
  domain = "vpc"
  tags = {
    Name = "${var.instance_name}-eip"
  }
}

resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this.id
}

// ------------------
//  Key Pair
// ------------------

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "${var.instance_name}-key-pair"
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.this.key_name}.pem"
  content  = tls_private_key.this.private_key_pem
}