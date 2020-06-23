resource "aws_instance" "jenkins_master" {
  ami = var.ami
  instance_type = "t2.medium"
  key_name = "jkey"
  subnet_id = module.vpc.public_subnets.1
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.servers-sg.id]
  #user_data = file("${path.module}/install_ansible.sh")
   
  tags = {
    Name = "jenkins_master"
  }

   connection {
    host = aws_instance.jenkins_master.public_ip
    user = "ec2-user"
    private_key = file("jkey")
  }

  provisioner "file" {
    source      = "../deployment"
    destination = "/home/ec2-user/"
  }

    provisioner "file" {
    source      = "../Jenkins-Master/ansible"
    destination = "/home/ec2-user/"
  }

 provisioner "remote-exec" {
    inline = [
      "sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y",
      "sudo yum update -y ",
      "sudo yum install ansible -y",
      "sudo yum install git -y",
      "ansible-playbook ansible/jenkins.yaml"



    
      
    ]
  }
}
