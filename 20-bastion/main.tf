resource "aws_instance" "bastion" {
 ami = local.ami_id # Replace with your desired AMI ID
 instance_type = "t3.micro"
 tags = {
   Name = "ExampleInstance"
 }
}