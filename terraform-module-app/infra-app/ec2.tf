#key pair(login)

resource "aws_key_pair" "my_key" {
  key_name   = "${var.env} - infra-app-key"
  public_key = file("${path.module}/terra-key-ec2.pub") #used the function that read the file content
  
  tags = {
    Environment=var.env
  }
}

#vpc
resource "aws_default_vpc" "default" {

}

#security group
resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-infra-app-sg"
  description = "This will add a TF genefated secuirty group"
  vpc_id      = aws_default_vpc.default.id # interpolation

  #inbound  
  ingress = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      description      = "SSH open"
    },

    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      description      = "HTTP open"
    },
    ]

  #outbound rules 
  egress = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # all port range
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    description      = "all access open outbound"
  }]

  tags = {
    Name = "${var.env}- infra-app-sg"
  }

}

# ec2 instance
resource "aws_instance" "my_instance" {
  count = var.instance_count # meta argument 


  depends_on = [aws_security_group.my_security_group, aws_key_pair.my_key]

  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = var.instance_type         # var.aws_instance_type #this for the varible
  ami             = var.instance_ami_id # amazon linux

  
   root_block_device {
    volume_size = var.env == "prd" ? 15 : 8
  }
  tags = {
    Name = "${var.env}-infra-app-instance"
    Environment = var.env
  }
}