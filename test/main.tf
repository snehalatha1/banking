resource "aws_instance" "ec2-server" {
  ami           = "ami-02eb7a4783e7e9317" 
  instance_type = "t2.micro" 
  vpc_security_group_ids= ["sg-0d68db1bfb4432b4f"]
  tags = {
    Name = "Terraform-server"
  }
  provisioner "local-exec" {
      command = " echo ${aws_instance.ec2-server.public_ip} > /home/ubuntu/inventory "
  } 
}
