resource "aws_key_pair" "aws_key_pair" {
  key_name   = "Deployer"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2_web" {

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.avg_subnet_pub.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.avg_sg_web.id]
  key_name                    = aws_key_pair.aws_key_pair.key_name

  tags = {
    name = "Ec2 da Aplicacao Python"
  }
  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_instance" "ec2_web_redun" {

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.avg_subnet_pub.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.avg_sg_web.id]
  key_name                    = aws_key_pair.aws_key_pair.key_name

  tags = {
    name = "Ec2 Redundancia"
  }
  lifecycle {
    prevent_destroy = true
  }
}



resource "aws_instance" "ec2_data-base" {

  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.avg_subnet_priv.id
  vpc_security_group_ids = [aws_security_group.avg_sg_db.id]
  key_name               = aws_key_pair.aws_key_pair.key_name

  tags = {
    name = "Ec2 do  MongoDB"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_instance" "ec2_back-up" {

  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.avg_subnet_priv.id
  vpc_security_group_ids = [aws_security_group.avg_sg_db.id]
  key_name               = aws_key_pair.aws_key_pair.key_name

  tags = {
    name = "Ec2 de back-up"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_instance" "ec2_mysql" {

  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.avg_subnet_priv.id
  vpc_security_group_ids = [aws_security_group.avg_sg_db.id]
  key_name               = aws_key_pair.aws_key_pair.key_name

  tags = {
    name = "Ec2 mysql"
  }
  lifecycle {
    prevent_destroy = true
  }
}