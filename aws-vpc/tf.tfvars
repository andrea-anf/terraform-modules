default_tags = {
  "Environment" : "test",
  "Region" : "us-east-1"
}

cidr_block    = "172.16.0.0/16"
subnets_count = 3

vpc_sg_ingress_rule_list = [
  {
    description      = "rule for https"
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
]

vpc_sg_egress_rule_list = [
  {
    description      = "allow all"
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
]