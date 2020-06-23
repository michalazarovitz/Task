resource "aws_instance" "web_server" {
  ami = "ami-09d95fab7fff3776c"
  instance_type = "t2.micro"
  key_name = "jkey"
  associate_public_ip_address = true
  subnet_id = module.vpc.public_subnets.0
  vpc_security_group_ids = [aws_security_group.servers-sg.id]
   
  tags = {
    Name = "web_server"
  }

   connection {
    host = aws_instance.web_server.public_ip
    user = "ec2-user"
    private_key = file("jkey")
  }
 provisioner "remote-exec" {
    inline = [
      "sudo yum install java-1.8.0-openjdk -y",
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user"
      
    ]
  }

}
